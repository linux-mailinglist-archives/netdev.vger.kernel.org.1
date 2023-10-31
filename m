Return-Path: <netdev+bounces-45424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5A27DCDC4
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 14:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E003B20D93
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004C812E7D;
	Tue, 31 Oct 2023 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hpUfFZKA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920F110FC
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 13:26:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6044FDE
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 06:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698758808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eI/NB+UK7wm+ikX7wMjjd1LtGrSm/qZ7Qv6AHobbkPs=;
	b=hpUfFZKARRkCLpjWMlxRttLcYrMRYNxZsMflA2YWlO//3xRtLIb2TsSykVZRLIX3YMSSdp
	Kf7wwNAFgoWWOJma991VFYi+UFhfqmnv5lH0p9+1NnbMDEqSeLJeFBVuc6VIEQkdpatokZ
	jafEQJ08HMS/wKbDcvwj3CkQ/GpTfjc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-pJpyFkLbNyetnDk1CeVP_Q-1; Tue, 31 Oct 2023 09:26:47 -0400
X-MC-Unique: pJpyFkLbNyetnDk1CeVP_Q-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-41cdffe4d1cso70178191cf.0
        for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 06:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698758806; x=1699363606;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eI/NB+UK7wm+ikX7wMjjd1LtGrSm/qZ7Qv6AHobbkPs=;
        b=izCGxq5QyFTGbmwvS7+LMX13gPXwBQ8WWMAUrkC/JJJKTvYjzMpdTarxs3qiobWqzu
         OeAJNZFZnOpom1EUw7Wf2NVbTsWJOCBwsorQGURd8vEeagouyvT/7RHdD5C3oFefMDf0
         M1pf5lUc9X+4URIEEgzRfR6EOD1ODqRQ53kMdUIs/WpZNebsp8sRK407QafpQhUEG4RI
         quZIm2hU146rYbW9m5Lc+jG7dLYOwUt9ZP44UWHvGw9tvaAwyCeZCD2kHtcP4+xCjKY1
         hNFav63sBnGhszeK88IIrza0QVpX3tX1H9y3OY15Z+YdiaHYs1PJjKsIntDL8QW5I38w
         4VTA==
X-Gm-Message-State: AOJu0YwVNPx9QD4IIVhCw2Bxrl+j2rES+PXtAnLiD8ujT6bwhNZX/SN2
	U5M9FpYeIkHJy1Va6xSijlBMfbGi8XaUoYGCJSeS0ngK4fMBW6HUVVDgeUfN/ua2OsOZOAXkUvb
	jBj8EWwRmfjYGProM
X-Received: by 2002:ac8:5c07:0:b0:412:395c:e794 with SMTP id i7-20020ac85c07000000b00412395ce794mr16506854qti.50.1698758806646;
        Tue, 31 Oct 2023 06:26:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQJ+JdW34kAi/vPRSUYYZ/SunG5KPuPwv6RMEn5yGHPjewye+0V9zLeMALeZ3Oa1GIJGE7BQ==
X-Received: by 2002:ac8:5c07:0:b0:412:395c:e794 with SMTP id i7-20020ac85c07000000b00412395ce794mr16506834qti.50.1698758806379;
        Tue, 31 Oct 2023 06:26:46 -0700 (PDT)
Received: from fedora ([142.181.225.135])
        by smtp.gmail.com with ESMTPSA id w26-20020ac84d1a000000b00405502aaf76sm492115qtv.57.2023.10.31.06.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 06:26:46 -0700 (PDT)
Date: Tue, 31 Oct 2023 09:26:44 -0400
From: Lucas Karpinski <lkarpins@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/net: synchronize udpgso_bench rx and tx
Message-ID: <vzz3qfbfq52qja24y25lopif27sdwyvz3jmmcbx5wm6jc5l53b@fy7ym6xk4zsb>
References: <6ceki76bcv7qz6de5rxc26ot6aezdmeoz2g4ubtve7qwozmyyw@zibbg64wsdjp>
 <e8a55d0518da5c1f9aba739359150cad58c03b2b.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a55d0518da5c1f9aba739359150cad58c03b2b.camel@redhat.com>
User-Agent: NeoMutt/20231006

> Since you wrote the same function verbatim in 3 different files, I
> think it would be better place it in separate, new, net_helper.sh file
> and include such file from the various callers. Possibly additionally
> rename the function as wait_local_udp_port_listen.
>
Thanks, I'll move it over. I think it would be best though to leave udp
out of the name and to just pass the protocol as an argument. That way
any future tcp tests can also take advantage of it.

Lucas


