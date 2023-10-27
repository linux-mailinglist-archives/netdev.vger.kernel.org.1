Return-Path: <netdev+bounces-44723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24357D96EB
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 13:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A524228237B
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9363418C04;
	Fri, 27 Oct 2023 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zUbdpQTm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A301864D
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 11:49:17 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2106FC0
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 04:49:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32d895584f1so1373344f8f.1
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 04:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698407354; x=1699012154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUug1qIw57mr+DRpdd7GliSwdBMty2Oz1w0OdwZh2wo=;
        b=zUbdpQTmv08t5F2FfqV/bUjHd2AENx0tS9j/5G4ZfhQ/F1nsAR4Ilwot8c7fE9h5CG
         tOuo8OxDdL/SyIYXPCqj3y+qWH/o9mGEvIO18MWBmB+ir/WDfLulA2fPt8uCFPORs0ee
         xdEzLiyiApJyeGmTSsHqL4uvUTFzJ7l7ayHrB3TqWPhfW/W0H572XUfz0EER9jMsQjSE
         oP+My/+db2q2pSxQXmw6M6lgEVEcByL5G0XzlEed47c4Phs2CXYgaLHyxth7fLhn6bpb
         1wsL5ufdbfdB640oKaxP6D0w0y3eTIdIi9RTTizTVhnj07p8FA60Hmri6MHecUodGF/G
         7z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698407354; x=1699012154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUug1qIw57mr+DRpdd7GliSwdBMty2Oz1w0OdwZh2wo=;
        b=gMCx7xPJfjpb/fH5XW3kmTu17Uc1zldT5FH54v659jZkPa02EDSParIMerVBPlLtHQ
         DrsSz7wCdjDSHKfRtZBCdVZECOo/pNSeeS3rgP5qMIibDtV8swNz9WAoNs+eizTvkKQe
         zlV7DptcvYC187q/N0Wed5VYOEzCfgi7cgp/4Kz6Z4qqYw4F6NayQLlndJ5pUwSSVt+V
         YoTzUsgn4rDqhplbNNtV/8DW97hmxlmfFwvwdJjI09aoRs+31ovRO0bvB4zr5uqZ3woQ
         mJSbmP3p6c0d3lyQbCb0tQMErXMC1RH1l+vAfTSaNO+EC7JEQsL27km9R1oVHBg4leK5
         B5Jw==
X-Gm-Message-State: AOJu0Yx9BjVsOjcwdj6jrIYCCBGvVZpCuwQaI67khdqxKPHKWdFOkgSD
	An8xa8pmYaMYUgLi6mFB4/lwOA==
X-Google-Smtp-Source: AGHT+IHdHIPlDJMXyZBHvSDTolKHJH+uKVMA1F9BN32sTR8LYz4kzbcC9IvfvgWuJOdhdg8u+hIgwg==
X-Received: by 2002:adf:f14a:0:b0:32d:9f1b:3a1f with SMTP id y10-20020adff14a000000b0032d9f1b3a1fmr1983922wro.31.1698407354572;
        Fri, 27 Oct 2023 04:49:14 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c13-20020adfe74d000000b0032da49e18fasm1633927wrn.23.2023.10.27.04.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 04:49:14 -0700 (PDT)
Date: Fri, 27 Oct 2023 14:49:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
	Dai.Ngo@oracle.com, tom@talpey.com, trond.myklebust@hammerspace.com,
	anna@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net v2] net: sunrpc: Fix an off by one in
 rpc_sockaddr2uaddr()
Message-ID: <9a3be793-0d42-4588-8c04-c930671e7ac4@kadam.mountain>
References: <31b27c8e54f131b7eabcbd78573f0b5bfe380d8c.1698184674.git.christophe.jaillet@wanadoo.fr>
 <ZTkmm/clAvIdr+6W@tissot.1015granger.net>
 <20231025092829.6034bfcd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025092829.6034bfcd@kernel.org>

On Wed, Oct 25, 2023 at 09:28:29AM -0700, Jakub Kicinski wrote:
> On Wed, 25 Oct 2023 10:30:51 -0400 Chuck Lever wrote:
> > Should these two be taken via the NFS client tree or do you intend
> > to include them in some other tree?
> 
> FWIW we're not intending to take these. If only get_maintainer
> understood tree designations :(

I accidentally markedt his NFS patch as net on Oct 11 as well.  :/

https://lore.kernel.org/all/356fb42c-9cf1-45cd-9233-ac845c507fb7@moroto.mountain/

regards,
dan carpenter

