Return-Path: <netdev+bounces-39486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F717BF74C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C5E1C20993
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C646171D7;
	Tue, 10 Oct 2023 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="etcjmszM"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC093EAF9
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 09:29:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3134F94
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696930140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OxCiYvYV9qvLPGaQcB0kw4NAjm9ttFkbDiaJd+SrBGA=;
	b=etcjmszMFTmkBJXIXsHS7MxZ/qnOFmUjPlPJyjoW5/VA0wqfNsY97+ZtUdVooifRvRHz3F
	vb0uvUlCIdnfLi23X2UnKyr3CkVqvE6iVuz2mHItuyB1fAZZuR0+pWsYJqTFj6W+y79SXi
	5HMRAc5ScRlGKItCNti8H6FjOdJXxFI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-YJBDyET7NDSCDMG1gbbRiQ-1; Tue, 10 Oct 2023 05:28:57 -0400
X-MC-Unique: YJBDyET7NDSCDMG1gbbRiQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-534c9a316cbso821547a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:28:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696930136; x=1697534936;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxCiYvYV9qvLPGaQcB0kw4NAjm9ttFkbDiaJd+SrBGA=;
        b=qOvi2mX0vUeYAkTGEcnMqrtpPVZrjUNGEamn9NPa0hLxV0/LqKNdPlwMLA5GWmhFUo
         GGwBakwojSHj3HSosciCEqoXWj5X/yXuWT1CLf8uv2MwB8665ZJeJ6e71xqbU7Ca3uEv
         YcBOjtwARPtWMUn8ZS0aNH3bEUpkLD0HRmQ5myRJz+dg9ZZKoRqclspkI0zvEhBmzMHd
         5gS7b1VXEOZGsed04iroaTMXZd3aKxZOwuNQucLC2Qut/ytZuzZqDFxFCumsueNjZYbc
         ako+a9rqmexHjm/gZLpFPrMSqc0X1hDCKFn+KrolT7lNLPR9w+Y9a+/ndGUopnn7DRNw
         N2OA==
X-Gm-Message-State: AOJu0Yxm3TdnHUoXKptIQuweLWZSLtnapMVlYvyrxu4u9ccwrWYT1yay
	GxC+jBr8um3opuU3yHwpMyczzt59fXwSS+xAcxh3Ac79JU0ia0qrg5Mgaen5LMrbeQ0oGGz8jyL
	BQjCP5xpgJmZydeZ7b8MxTccd
X-Received: by 2002:a05:6402:40c2:b0:523:37cf:6f37 with SMTP id z2-20020a05640240c200b0052337cf6f37mr14733549edb.4.1696930136466;
        Tue, 10 Oct 2023 02:28:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJPAx0QHx22OMargM+EBFoGBj2R+pr1dyTcELronIVBN9Cn975WI9liuJm10euXLGllBG8kw==
X-Received: by 2002:a05:6402:40c2:b0:523:37cf:6f37 with SMTP id z2-20020a05640240c200b0052337cf6f37mr14733531edb.4.1696930136150;
        Tue, 10 Oct 2023 02:28:56 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-228-243.dyn.eolo.it. [146.241.228.243])
        by smtp.gmail.com with ESMTPSA id c6-20020aa7c746000000b00537f5e85ea0sm7326021eds.13.2023.10.10.02.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 02:28:55 -0700 (PDT)
Message-ID: <39546eb7836e577b53a3b403a2bb20ec07010f25.camel@redhat.com>
Subject: Re: [net-next PATCH] octeon_ep: pack hardware structures
From: Paolo Abeni <pabeni@redhat.com>
To: Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, hgani@marvell.com
Cc: egallen@redhat.com, mschmidt@redhat.com, Veerasenareddy Burru
 <vburru@marvell.com>, Sathesh Edara <sedara@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>
Date: Tue, 10 Oct 2023 11:28:54 +0200
In-Reply-To: <20231006120225.2259533-1-srasheed@marvell.com>
References: <20231006120225.2259533-1-srasheed@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-10-06 at 05:02 -0700, Shinas Rasheed wrote:
> Add packed attribute to hardware structures.

Could you please elaborate a bit more why this is needed? Is this a
bugfix? Or something needed by later changes? Please update the
changelog accordingly

Thanks!

Paolo


