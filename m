Return-Path: <netdev+bounces-30358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FD3787023
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3312C1C20B2D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7419728911;
	Thu, 24 Aug 2023 13:20:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C0100A7
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:20:13 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F6A1BD3
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:19:40 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fef34c33d6so35575715e9.3
        for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692883169; x=1693487969;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UN2TTRUMvRvKa7NTgzItHpKtpEhHmVIDwM15mecbrk8=;
        b=XEv4h5+mhhyTneMGtnZ5kNcl2ecrYknRNIFApc1C6mHODNfwu1WrphCFupdQMI55qr
         sHn7218S+52cT76/HlKMiC0uEaso5FH+abwdMLdhd0DIbI3pCZm5WZ5Uk8Hlm0WXWfsl
         ppgQdF7MLv/OyajHBGunmciLZfOpBI7PjPuAxyq4r8jKBvFNwtsdD5YDUBHwR00mSSrm
         KMvkDuFvhjdJkWCIlMRAOivUCDXPcuY4Zl9+o26uh1Q9LjvDxWwD/2dt3/Aotl0wj7Zl
         di95yJmU7p8/Yo0lwnkDAUqMhj9bkfXxZCkU4JfbpyTI0KNkQOncloPhtYDXhidDj6Tv
         yzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692883169; x=1693487969;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UN2TTRUMvRvKa7NTgzItHpKtpEhHmVIDwM15mecbrk8=;
        b=cvNd5GAYty5RWts2QHXAzevCKdzYh/q6jdLPF34fRYTFy3dS5eX/Yc/VUp0cfMqdYg
         VgvmCobmm9UYiYR3Sk7td6PmqBxIbyxGFGHMfIDRr2qKwACh0kgXZlvBXxPMpyrQi4QM
         rPN9mT3FUFDTxueOvG/Rozk3YjrnZlfQFsjHNOTBQhoqMDBohvc6NTnDE9abLP3oxQEb
         zPKyiYH72nKS/ku8V2tXQkV2MjLMC1otw+8kMFx0NpWAG7AxDi3mGlq3Ek1uaQ3MCPEV
         ohNSqFKxSCK3RWzglHGtGS6H+TFqO7sKq3hjTw/UQXomU2W/jcZJybr4m97mHvB2RHgR
         abJw==
X-Gm-Message-State: AOJu0Yw0o661WFje9iEPlD/Zpx9VHNdlc9jfCkB5rv50+Lr4whJ+TkdO
	XCb3pZkSfVkaEAHtiReSpBo=
X-Google-Smtp-Source: AGHT+IEfB+byHWm4h6aFefnMPW48Uq0rw0F8yLsaVk2FZ0ngY+wm2vn8XwNKbdNxPb0KbHJBBzZG2A==
X-Received: by 2002:adf:fc0b:0:b0:317:69d2:35be with SMTP id i11-20020adffc0b000000b0031769d235bemr10740125wrr.30.1692883169550;
        Thu, 24 Aug 2023 06:19:29 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:1a5:1436:c34c:226])
        by smtp.gmail.com with ESMTPSA id l6-20020adfe586000000b0031989784d96sm22436204wrm.76.2023.08.24.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 06:19:29 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next 2/5] tools: ynl-gen: set length of binary fields
In-Reply-To: <20230824003056.1436637-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 23 Aug 2023 17:30:53 -0700")
Date: Thu, 24 Aug 2023 14:16:04 +0100
Message-ID: <m2sf88funf.fsf@gmail.com>
References: <20230824003056.1436637-1-kuba@kernel.org>
	<20230824003056.1436637-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> writes:

> Remember to set the length field in the request setters.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/generated/ethtool-user.h | 4 ++++
>  tools/net/ynl/generated/fou-user.h     | 6 ++++++
>  tools/net/ynl/ynl-gen-c.py             | 1 +
>  3 files changed, 11 insertions(+)
>
> diff --git a/tools/net/ynl/generated/ethtool-user.h b/tools/net/ynl/generated/ethtool-user.h
> index d7d4ba855f43..ddc1a5209992 100644
> --- a/tools/net/ynl/generated/ethtool-user.h
> +++ b/tools/net/ynl/generated/ethtool-user.h
> @@ -1422,6 +1422,7 @@ ethtool_wol_set_req_set_sopass(struct ethtool_wol_set_req *req,
>  			       const void *sopass, size_t len)
>  {
>  	free(req->sopass);
> +	req->_present.sopass_len = len;
>  	req->sopass = malloc(req->_present.sopass_len);
>  	memcpy(req->sopass, sopass, req->_present.sopass_len);
>  }
> @@ -4071,6 +4072,7 @@ ethtool_fec_set_req_set_stats_corrected(struct ethtool_fec_set_req *req,
>  					const void *corrected, size_t len)
>  {
>  	free(req->stats.corrected);
> +	req->stats._present.corrected_len = len;
>  	req->stats.corrected = malloc(req->stats._present.corrected_len);
>  	memcpy(req->stats.corrected, corrected, req->stats._present.corrected_len);
>  }
> @@ -4079,6 +4081,7 @@ ethtool_fec_set_req_set_stats_uncorr(struct ethtool_fec_set_req *req,
>  				     const void *uncorr, size_t len)
>  {
>  	free(req->stats.uncorr);
> +	req->stats._present.uncorr_len = len;
>  	req->stats.uncorr = malloc(req->stats._present.uncorr_len);
>  	memcpy(req->stats.uncorr, uncorr, req->stats._present.uncorr_len);
>  }
> @@ -4087,6 +4090,7 @@ ethtool_fec_set_req_set_stats_corr_bits(struct ethtool_fec_set_req *req,
>  					const void *corr_bits, size_t len)
>  {
>  	free(req->stats.corr_bits);
> +	req->stats._present.corr_bits_len = len;
>  	req->stats.corr_bits = malloc(req->stats._present.corr_bits_len);
>  	memcpy(req->stats.corr_bits, corr_bits, req->stats._present.corr_bits_len);
>  }
> diff --git a/tools/net/ynl/generated/fou-user.h b/tools/net/ynl/generated/fou-user.h
> index d8ab50579cd1..a8f860892540 100644
> --- a/tools/net/ynl/generated/fou-user.h
> +++ b/tools/net/ynl/generated/fou-user.h
> @@ -91,6 +91,7 @@ fou_add_req_set_local_v6(struct fou_add_req *req, const void *local_v6,
>  			 size_t len)
>  {
>  	free(req->local_v6);
> +	req->_present.local_v6_len = len;
>  	req->local_v6 = malloc(req->_present.local_v6_len);
>  	memcpy(req->local_v6, local_v6, req->_present.local_v6_len);
>  }
> @@ -99,6 +100,7 @@ fou_add_req_set_peer_v6(struct fou_add_req *req, const void *peer_v6,
>  			size_t len)
>  {
>  	free(req->peer_v6);
> +	req->_present.peer_v6_len = len;
>  	req->peer_v6 = malloc(req->_present.peer_v6_len);
>  	memcpy(req->peer_v6, peer_v6, req->_present.peer_v6_len);
>  }
> @@ -192,6 +194,7 @@ fou_del_req_set_local_v6(struct fou_del_req *req, const void *local_v6,
>  			 size_t len)
>  {
>  	free(req->local_v6);
> +	req->_present.local_v6_len = len;
>  	req->local_v6 = malloc(req->_present.local_v6_len);
>  	memcpy(req->local_v6, local_v6, req->_present.local_v6_len);
>  }
> @@ -200,6 +203,7 @@ fou_del_req_set_peer_v6(struct fou_del_req *req, const void *peer_v6,
>  			size_t len)
>  {
>  	free(req->peer_v6);
> +	req->_present.peer_v6_len = len;
>  	req->peer_v6 = malloc(req->_present.peer_v6_len);
>  	memcpy(req->peer_v6, peer_v6, req->_present.peer_v6_len);
>  }
> @@ -280,6 +284,7 @@ fou_get_req_set_local_v6(struct fou_get_req *req, const void *local_v6,
>  			 size_t len)
>  {
>  	free(req->local_v6);
> +	req->_present.local_v6_len = len;
>  	req->local_v6 = malloc(req->_present.local_v6_len);
>  	memcpy(req->local_v6, local_v6, req->_present.local_v6_len);
>  }
> @@ -288,6 +293,7 @@ fou_get_req_set_peer_v6(struct fou_get_req *req, const void *peer_v6,
>  			size_t len)
>  {
>  	free(req->peer_v6);
> +	req->_present.peer_v6_len = len;
>  	req->peer_v6 = malloc(req->_present.peer_v6_len);
>  	memcpy(req->peer_v6, peer_v6, req->_present.peer_v6_len);
>  }
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index bdff8dfc29c9..e27deb199a70 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -428,6 +428,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>  
>      def _setter_lines(self, ri, member, presence):
>          return [f"free({member});",
> +                f"{presence}_len = len;",
>                  f"{member} = malloc({presence}_len);",
>                  f'memcpy({member}, {self.c_name}, {presence}_len);']

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

