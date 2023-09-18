Return-Path: <netdev+bounces-34490-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDEF7A45E9
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 11:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6911C21063
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 09:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9768E1BDC5;
	Mon, 18 Sep 2023 09:30:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF140F4EA
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 09:30:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C8A11B
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 02:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695029407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MC7WEV65sN26AV9HGp9mkfHY0cKCJI1fnMY5C8dzRgg=;
	b=WqmeHrVPliSlxtRUt2/I4RrNRHbdc+1FsDQLgdZy3xOOe+H03xVH/vc3W3fSQNsMt9M85C
	zL2VxMVPnNRQSts1rikET7pdB/IcecZucdAWH2XJrMan1sLp+arnN1TTdVPH1WSjb1da8R
	vToXJHoFjWgAV7y9UYtQC23lFeHgMBo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-6vFgNVMAPuuL9xnshCBbBg-1; Mon, 18 Sep 2023 05:30:04 -0400
X-MC-Unique: 6vFgNVMAPuuL9xnshCBbBg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fe182913c5so31946505e9.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 02:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695029403; x=1695634203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MC7WEV65sN26AV9HGp9mkfHY0cKCJI1fnMY5C8dzRgg=;
        b=GntKC64BC2P21SROOL4srbAJEDFx7/VrH15qVKaoTOoH6IHbaEWyOD3tSIEnaWFwOL
         3bTSPa4h7WfuDm6YPu0y/7XO6drRHKpMcF8OXUilPt9RgRyfuFVw7wFasH0bCg7v7pV/
         QG7V31w3NXkldK4hIsLMeIk2OIYNrt+ZLcf0LKqRnQuh2Rd4fppuy+yieiZMrHGrTNyv
         0t1HbGrK680vE1FfYVyoP+EiKEJN5+0lAH8xIXT5XtkVA79RXyHFRt53Rq1xtbsiLaTT
         N8RRf/x3eq4XeO0j5QDjj//d60Re99ujHgQAIyXvE9beHnIwhQtEwp6st5bYGRzsxEq5
         HSSQ==
X-Gm-Message-State: AOJu0Ywnw/AbHORcN2RKsidbZ2tkcno2byiPKkypBEc7ewa8iusxTg52
	cP9UZwzKTaP1mA/3wJIF86rx0Mz1Rk4VWMKr52c16DBbv+DnJY8u/cOoD6tKDYmJgJp6Jos2+bH
	XMTnOaJqbnue2SpPVL1qc3Y+J
X-Received: by 2002:a05:600c:218b:b0:401:eb0:a980 with SMTP id e11-20020a05600c218b00b004010eb0a980mr6780382wme.14.1695029402874;
        Mon, 18 Sep 2023 02:30:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtJ/tlx4YuN45PxIP+ezz3nxgU6TNiNFLx74fX8XaQBKwEGQi2mgMJuicQxFAO1NAnXDD/sw==
X-Received: by 2002:a05:600c:218b:b0:401:eb0:a980 with SMTP id e11-20020a05600c218b00b004010eb0a980mr6780374wme.14.1695029402519;
        Mon, 18 Sep 2023 02:30:02 -0700 (PDT)
Received: from localhost ([37.160.2.82])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c230700b003fefcbe7fa8sm11971722wmo.28.2023.09.18.02.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:30:02 -0700 (PDT)
Date: Mon, 18 Sep 2023 11:29:58 +0200
From: Andrea Claudi <aclaudi@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] fix set-not-used warnings
Message-ID: <ZQgYluN7+5eDr6qs@renaissance-vector>
References: <20230917170825.26165-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230917170825.26165-1-stephen@networkplumber.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 17, 2023 at 10:08:25AM -0700, Stephen Hemminger wrote:
> Building with clang and warnings enabled finds several
> places where variable was set but not used.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Andrea Claudi <aclaudi@redhat.com>


