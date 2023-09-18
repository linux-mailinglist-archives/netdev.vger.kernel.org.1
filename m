Return-Path: <netdev+bounces-34487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BFA7A45E1
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 11:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA601C20431
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62667156F5;
	Mon, 18 Sep 2023 09:28:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AFE134BD
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:28:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC06B5
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 02:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695029296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xuvYthy3e6B7JSC0V9D8RdJxDbtEhheNOXF7LwHrspA=;
	b=MlGKEB1pgOHtI63byenTQ7bFFe9q+jyE3jT9SUDT+vvktzjXPiVLSXfag91YGKXrpemUNB
	lAXyMXilXsNUPttz6o7x6DVgIU8CUlh8kiNPCb7Zd8WJbPAT404oKbdI6vnmhPGf1n447Y
	JfyYH8hN2pAkqyuLcQsMpygpO4cDL+k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-vOodOCy8NbK1JMFHV0mfng-1; Mon, 18 Sep 2023 05:28:13 -0400
X-MC-Unique: vOodOCy8NbK1JMFHV0mfng-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-404fa5c1d99so11925785e9.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 02:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695029291; x=1695634091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuvYthy3e6B7JSC0V9D8RdJxDbtEhheNOXF7LwHrspA=;
        b=ntSN5NDNyLwPcv8CoEvfkDHFbCVj8PDtgHM9Z/XLAXIKJcHQmmJYl5wHaK1GLwFNCL
         +10aU7LXvUJ5KUUrTFea0zNYsxsBEpp+1fFDH3ShR9UkAyQdQ3kGVqoePwJ/A0E8cjCY
         zxQIfdASBnJLuyFQ6NVElPhxtsVatTz9ETFJqgrfTvMITJA663y8G4gOTpU3IpvnY3mU
         0EzhLTMwWHGpv+qLV0jniw5Fyr+S20qfwr6QDoXYH0QolT6qtPU6/cQsRu7TFVxSb0bs
         3EAmDmsETXdfBWbV8EBYcn06xzIcIJVi66tTUwNG6zsOJdNzzCgayk+MhoLNWrY2gGA8
         i0tA==
X-Gm-Message-State: AOJu0YxJuD3sPESunX9XI2ZjHofCXKmIuhP3Ecn55V/jiqmze4uh0ahn
	HnjNcFSX+Sp3BF9mIc6XbNwyOXNGDvx5x+PzLELU3XWrOdFLI5SmZ/IHPjSJ5f02/fZn1nE6YAD
	wS0MTRogA7tanD6lRVZK7Tivg
X-Received: by 2002:a5d:58e1:0:b0:319:79bb:980c with SMTP id f1-20020a5d58e1000000b0031979bb980cmr6471587wrd.64.1695029291788;
        Mon, 18 Sep 2023 02:28:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4zcxllvAx7KJ5OpPMSGtFgGeEiGq4GvnoJxyWB/ntoU9UWCE5jqpRoNL1109iKtPQPmkeUw==
X-Received: by 2002:a5d:58e1:0:b0:319:79bb:980c with SMTP id f1-20020a5d58e1000000b0031979bb980cmr6471575wrd.64.1695029291446;
        Mon, 18 Sep 2023 02:28:11 -0700 (PDT)
Received: from localhost ([37.160.2.82])
        by smtp.gmail.com with ESMTPSA id p14-20020a1c740e000000b003fe407ca05bsm14783436wmc.37.2023.09.18.02.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:28:10 -0700 (PDT)
Date: Mon, 18 Sep 2023 11:28:06 +0200
From: Andrea Claudi <aclaudi@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2 v2] allow overriding color option in environment
Message-ID: <ZQgYJrKxyBLhWMrM@renaissance-vector>
References: <20230916150326.7942-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916150326.7942-1-stephen@networkplumber.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 16, 2023 at 08:03:26AM -0700, Stephen Hemminger wrote:
> For ip, tc, and bridge command introduce IPROUTE_COLORS to enable
> automatic colorization via environment variable.
> Similar to how grep handles color flag.
> 
> Example:
>   $ IPROUTE_COLORS=auto ip -br addr
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Andrea Claudi <aclaudi@redhat.com>

Thanks.


