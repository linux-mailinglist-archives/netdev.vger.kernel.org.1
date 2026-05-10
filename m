Return-Path: <netdev+bounces-286313-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E3MHyWmAGoqLQEAu9opvQ
	(envelope-from <netdev+bounces-286313-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:37:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DECDC504E09
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:37:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 162B8301DAC9
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CEB39183B;
	Sun, 10 May 2026 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="ePwnlxs0"
X-Original-To: netdev@vger.kernel.org
Received: from sonic306-21.consmr.mail.ne1.yahoo.com (sonic306-21.consmr.mail.ne1.yahoo.com [66.163.189.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72339FCB5
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.189.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427388; cv=none; b=czl/Bqvl/z1AYaeHRDH9cqangpJ8JnoSAuaLMJuE+hrr8DeIOlU5/BQSPLBx+ZYkm3Ehi56wbahVvG9xsUh/gK6Sk8Ykbvyx2LeyWuleWVfMfT18lEBgpTeafU8MW8yNM3Z3/tE4wOxBrINkN6FfXgKxr1VH+MD7xJ5A8TpNUUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427388; c=relaxed/simple;
	bh=WcON9c4xEYqsaVFwR8mhV70XFny6FFUtrfe/n0EP3mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVE3xJJ6QbGAUhfqC0CC2EB4dG569OUsIiMVx82+r0lfiGdGjMqgd0SeX1ieuCBjjEwl5aDzyqxjytYvoI2y4rbf7zvNq2/vuHZHXm449pg9u8u+rXQe+5oW53fGwhM6JOWLNBshDJNRq2ifc9msBqbTZVc7+q5ubDG36NbD+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=ePwnlxs0; arc=none smtp.client-ip=66.163.189.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778427386; bh=T2A7Mc/5PZhfBEiTFfCq37JoNDOfKkduYdOLZOgf6Pc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ePwnlxs0We+yXkj5HqEblyNJ7HElwfy6xgR7FTFnlIU9xZbPxvJijDSidDRK0RhwVQhEcj4p/FJ3uz/93N0C6szAHG/iwCEsJU/WLi/OHM89IBzEzH+xNGRd4Zr89f+77UehS9mScNoeMBnvredzwG2zPo88BJ1APLdjOoCnmW4mKkiQzUqzje/oOi9EMXXRn1x/8Kmhasoa20JurT6v8YU5jlr71dTpscAXIMmLeNiOy8c1Y1C0k45e7NYWD0yr5V1bqgiXkspeDL+pTEsNrbhFaOrlysJPTNs7X2Wksj01OEawLAMCaT8jmgrP7lkSbTWc5uHoLhNItY+GswWJeQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778427386; bh=fBmQNEoVjQr95bPoAN2SdiIQNW85Asg6BRtSUU2bW9a=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Dql2dIYZD9eb5lcARdGW1XSxdbl+lyPCMZuv69VuLllSIyEhig2zVBupQKa8Rvs/b1Aa1kQ6oYcYf3+6C6S3uKNBQ6qJZtRcNQhjey/NYU/Q1tE2MZBn4ENCSQcQ4JoQbZ8QGLcSFqgUoURSvr6aGZxNCkAwUZzumOP0VNMOgP7Bzbh45F8Vnv9GV119Fx94YyPpB8+zLVhThD+9QtWwor1/AK+BCvADifSen89QYHJRbV3VhvE7yZqEGy9Eafjmy8veGbHPA7DfqxLzvsfhMwkAPLGIwEsnjB15HrcY1UXaHyUnnHKiPp/WCE8STq35NQZk332p3xcM5DErvIgP3A==
X-YMail-OSG: Cf9tS74VM1l19Yq.fYqjm4AybB6gt1eWPm8_z_1nz0.gTKGebHeKhXUNHkKt_sH
 5XQmQln.eR40picRPuQX_5d9rG4kYLqPpPfMn0.s.U71dsl_K1CR5R2s3J0wiZP2DvpITjzJYWV5
 NRONbXL.j2k6LPipyvm0mHWJA2iji9eRA7UmoZpeyP8xzOiizLyH7ov9kfscCMEz8BIlQyh2YS7m
 VUrkFE4RUVlsyG_Dlvk6zEK3pZh8nVkNmULd7Cai27wsC4JfWY5CWlFScORZj_I5aJAiNeb8T6Jq
 BY9XlBIq_fTs6NMMF9gxo4ly2rppvt4vkWpuIMc2BwFGTGoyFcSOwWulCCRWo4nmaDPjbSyAvQJe
 IXsjJdEkQISkmJaxB0VoXVzJHPlM9dH53ukfkzM7L3X45VTrytPEwQ93_1MgsH6NrQ6Ykd7lyD.w
 gIEkVaHR_jDcHyvB0Qyd30QbrWlRQzBPlzw.49weVcYXf3GPqqvrW.YgT8WOivwYBCxchzpEiTQA
 Z9O7AwsZ0hCqJG7T.5xPgyUITh6t8wWbQvquRVieIKDUvBczIvcEbChtDOMZzbeqHehFPuSHcSXT
 MNj172y9cqjSxMJrHHXfelwYG8sFZcqs_Y6ei.9DW1VVLQSl933MoQmhWUoUUdbEXf2KvJ0GTKoD
 7kIdKAg2yylx.iAsNZH8PlAVslEtNXZXmmMdalGuz0hmBIPR0iSAKIvsZdh.W9tCzfKZ3zTR1GXL
 srYUvdOH3g64UvARCHKY0D_20cHvJO3lFchMdTDZiuCUdQHscV0RT.eQ3yVVJSKgYf4TUyW9iLlo
 DmkINX.ZUoevdpJqmUnIHxwX3qYSLyZIzzkYh9HhhEnR1sxdi.CxvWFAyY.Le2vvIm3FKGXSBJwI
 aHTy3JOMiAwqN7oRWip0LaUBQK9xERHBfDGbwWGdlw11ICUNQTjZFj4UGl44N7P9mr23q2GeP7__
 kyh3TTanPex.N6UzghHPTwiTKh82ubFsqLngsJxk2XknrBiP6mcgNrcU1_qfNbASyW414UEiklHI
 pGAUpJPwgLC_oWUQPK5hdMr3LaVvRHyngqSEN6lBaDnuM8sts5XOZkYuiePGYQpW4Mmyt7E4ZkR9
 38h92tMdzLcHyRwaYWGsFak74MP7u9Tx6ZdZ2GNxrnTQ0OseuRuqp1jPwTgjR5KXf6Ra1LZ9YGgJ
 Dk39TlleqYy6l456PwY3v.9jKM.H69_u.lCEyuGosO9u071jZiVsjb5HXmrGdaoHw8MBhZTsXNWc
 bF52haOtcCTNTBMfs40kf9ZIDgBSBMiWybqhf1qot78MTgj7QVLIiyBXZJJDOLd2Saj6Za.k7Y.M
 pV9VLF.mnrVJASpEucazKSHfrUh9fHu4qOWvJbNEIONhUCM5Q_WWqpP4t68W1_MR8xb0scs.aoLr
 _5meaHlWy6QLxI2.rjuu1WiTYkZg80xkfNPXJIcKVMxS_7otN1Df5peNn.F0eYbCuCFnPjwA4ooz
 lczGusvhsSjKPo9RMGdfeA5ClvNcu0nlIQFH8Xc1uKFGcNOrhkuNf.PPh26phgXmBFRxG4wgYlLg
 6qCYoLwIRBoAbvAjmYtbFN1oHGVDxmhB38jAIULz_Qjcs3lJYN4HdtHgMJN0y_3nn6XYH6gASr01
 a3uscf4wrqnLLYSb8Jr7VgBHRMhT.ijawxCrFdWiNNs2PLXWd_03.VvtW9w9F8kIpuTBCdmmruto
 r3nOwRimvixzi0JQKN.klGcXsp73RO.g6LYLl_lQw82MfoGj3JKRvT2eYZqp003o.f5PxpgCmt91
 gQSWh8FXJmQ4qHXAFfsaXCdHDRMtDxgYCzXWzqUylSGqXaFy5j6.Kz5LaD4LEUyFhmDqM514vqGd
 QFiu8Kz2rijFzQ_LyLthNggkLQ5cnnD46u4FRX69X73NN.MRDiuvJXC4mSRekB_zim0Dk1B_s3HB
 IyXEo0YyCRTr4LfbP5tmSaUpfcwzF7GvTfFmkc1zD0NWWLwnbzoWzL9iwDVNdFrmWbrsUr6Aaxgy
 WEhhHKzKb79KqdY2rlpaGTjQ_C9QE1MJXFldYc9PZbWWwE8TRIM9OAckkKxjw9fBSfgezsHJ6OWD
 u9Ayj_6jh7pWB03rSdWPQgtFT0iCP7aX82B2IigFDNYsFO1QlsSv3QnAb0.l8s2iyn4EOK2xm4ka
 OkbcgLnsiPUkN2vdTUylb8pWssPmO25ep_FZS79HUyedKcNs9OKFeENoVnvADP5R2t_M4T5AcMKJ
 tS_eiAoLihcmyIf9NpyQRrgLsjoM8X4EpX_9WToZyXXfBDEVJm9g0yn0y1I_tuerN_ZslBXQDAPt
 vlEST7gP8y9Un_JMsuVA2BuIeiNT8Z_YbpMD8JTo75NEZQ7Yn34eRskEb5w--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 9615a67f-e509-4ac7-bf51-b4c7450af4ea
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sun, 10 May 2026 15:36:26 +0000
Received: by hermes--production-ir2-89844b765-5fnlv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d4921e79d314600baeffb480359b7e18;
          Sun, 10 May 2026 15:26:07 +0000 (UTC)
Message-ID: <25285300-891c-464b-aeb9-df0f789ac720@yahoo.com>
Date: Sun, 10 May 2026 17:26:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 8/8] net: dsa: realtek: rtl8365mb: add bridge
 port flags
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com>
 <20260506-realtek_forward-v3-8-1d87c5f85a3b@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260506-realtek_forward-v3-8-1d87c5f85a3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: DECDC504E09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286313-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Action: no action

On 5/7/2026 4:58 AM, Luiz Angelo Daros de Luca wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> Implement support for bridge port flags to control learning and flooding
> behavior. This patch maps hardware functionalities to the following
> bridge flags:
> 
> - BR_LEARNING
> - BR_FLOOD
> - BR_MCAST_FLOOD
> - BR_BCAST_FLOOD
> 
> By default, all flooding types are enabled during port setup to ensure
> standard bridge behavior.
> 
> Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

