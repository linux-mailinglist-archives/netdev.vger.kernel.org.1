Return-Path: <netdev+bounces-296240-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7fxbEzB0JWpQIQIAu9opvQ
	(envelope-from <netdev+bounces-296240-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 15:37:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C409650A69
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 15:37:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=yahoo.com header.s=s2048 header.b="e//npSH6";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296240-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296240-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=yahoo.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53E7D3011BC4
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 13:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD602DF12F;
	Sun,  7 Jun 2026 13:37:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from sonic314-20.consmr.mail.ne1.yahoo.com (sonic314-20.consmr.mail.ne1.yahoo.com [66.163.189.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56472C11E1
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 13:37:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780839469; cv=none; b=d+ao8JtmqsD3mD/1JPKFvkxhYULqFOriI3mtZguk9KpD/QEbnyrkOMxokbYHQgpuKK4oHkLAq/53mLrvSnRxQCRciKIeqz6pwhiPbLlJZfGNu46CMb1E+lAumzWIHL0bXdvpWsCdW8/J+v7FsoaiUVWhoiy2JgFBYRyDho0a3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780839469; c=relaxed/simple;
	bh=TKV/6WCgaMwjYsWYdeQlMDzNzMnptRcV0L6Bk9B2Ypk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6QJrP0s1nMUubzXNWefJWZjIWOsjovTPt/bIZAalugXD5hKhLLljhr+WGY+ia8FYIosTBKcCDCfMtWzvYUdxqyCQEghjska1nd9XG85Q0dYxSgXvTkGx+JnHSLrOKe+gjRhnK4GjCH8TiFqkTFXC/WR8J8fsyWYdvGU0T7NojQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=e//npSH6; arc=none smtp.client-ip=66.163.189.146
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1780839468; bh=ftI/0fwtpfhLSCw0FxG3DApexfWjDxLD9LQrhgtlNa0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=e//npSH6A6r7pLZpOQiBXpLqULR5CqgEaHpjZGRB8J9Fo7KAepu4Kaz7r9xw55vWI7b2/Zy0G0ZctvgjmoSKb2TSxyQIQ2a4HHmb1kWa6kQbbELLd2ReR5m4zfuSZ4GqtV31FwqSKj37wnQxEloktj4OUqv5KbFxuUTJBxIJrB/bHwlNMK5VQAoPh6E8U4IvcpBoLWp1D9WUR/CE8nvgElDwPBVK25Z9qgaOgebIamFO/jq58HkjWYa5esn6YRuWzSKR7bXqBPCR6fsdQBaudElzBO87gvgAiFxgAMw8byjIu+t6CsGkqOZ5i+Y8EIKnzQB1kONRxY23GZMHiyBeKg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1780839468; bh=NyyLkgZ/HBGQoPhI1g1cSa3/Bahf8wsSj6VrXxzgd7e=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=QFE+0p8+rlbtDZCC+8OO0HWGNf8d2xsR6EqOIU+kG8doy8veL3Cd11PqcL5y4s+9+TawzVAXummF9XE3qBRAqdG1/LKs4zn8CzY1Zd1Hk88Yueu96pKdnB1MVR2L64yxox2jxGo/kJ5D8rX56ex5wpH+untSojR4BtZbtqCpFCGretLs0qRwP9jEMfGHzBe0ILWaGSupdTbeEn/V0t5zqD/u+s4c0sU+Hp/0Z2rRHxF3w5LtlQOMdq6MfI/5Zr2qDtIwKP5A7icSHkjoIrkZcOeh0RHjX89Z3sDGdGMoO7qgouCy9c2s/Wt6rWl4V6AaA689+9iBsu3s49wDmZlBRA==
X-YMail-OSG: r3sX7uIVM1ljZBKYAkiu9lqj61iQZGx.tVU17ONTgWZJZvaEEcXo4hF8Iq_Nsme
 c2I5cyxaMOs0NmgHIMsQVKTN8WrDOsPYoI7tx9XgO0lXPUmJs_rrjbvU4e1fHwz6kD2fE39qt4tG
 cpTIc.n2rPdQyQUUXrlys0BG9Uq5yRPNoMbI.TqnIPl80Ak0.kzhz1mBp3LYpgLfuTTnIWoZ41sx
 p_X62nsm.V1_k7RPembCg3wGO90HaQsmTlJjcGky4TPc22jOQvZ8YnuW_GYKPjh.DPQ6Do2iuA2k
 Zm9OlMzSo77BVdTeqpgEgeIQSZa2bHhOaQ5KVZnQ.lSc9jwe0iR.GNXMhTLZ80QJq7FsutSkixFV
 7jlob8fxcy8JxUG3xEKqih3WvkM6QV3vcOM2eFkuGJWXFQNLvUfrCkuOmBYJvYqMcY9dw8TsyVQk
 C_qkBURMnubU3EHYQCFw_6GeIv45BNuxF9toHEGHvEhGWHHo3VVsZwt30qWXKz70BIe8PfMUjU_G
 Q9yhu7sqgyHaaHJZ9ju_Bp3RZJCshwvod5nntRp18p5hM62nJZluuUCQdDpcxpxnA9dqijLXAeD1
 k.D_V43s5JH.hjx_fC5Pm2PgpNBAoNDqZNxQW_.CmM2dpg11_SkZ7qfIyXryK6pYzYOCBc08W8b_
 zKv6lN2cOh5SRLlIam5Dwzv3Jv9QrXoXQivZXjhz.uQDn4u0e_5spa8TKrsWDwSq8vEt69tOZEvg
 iDWw0djmJmqZD0Owi0MimrD1ae7mIWRcHjsyckB2L7QXI7p9Serl07Q7aEJj3.lDXZFKi7IJEM82
 ldyzqy.Zo3_okBC0_QsWHju9qnB6xF3Xmzz.98hTvNB.7TPoe1YUVGznbNz2W_3hyC1lYVGnPyL.
 S_NL3W7npkAY8vBgz4a45MrtDS6jYg.wgPlVOg1HQyt3_ECG8kjR9d8.yOUYLnE3Kn1jN0tqi0yc
 Y0Q35zxC3s4A_8k7myiX4Ubs3QybH.giNLales48tSdtCeVZ88WnWQogXJEx5dzciqqoopnJd89o
 zFYYDi.m7j.lz5tioyeUQoBZGeWa9CaDtNit3Im7CFdPHCUcw3YVTfh43IgSQGe5mC5vr2Dscde8
 8jaN9pZ1.E14VgbV5AKwOK7J0vj5cFMVgVoVd3M7Ol5NCnOUQ6Kgark4uNg9lXEnQBaZKXaMA2JU
 nXrH2ubWnpuit5sC3QO0HZPSlZJNkTawU3mw7dFdyt057jVri5T8PmwA2d4SO_UVDAp095GsJafU
 EmLmb_RzKemR2376183myCQYMwNboq_KGeFJDUiTbZGKM3ifB7s1Dgq.QGEbVRtjzdaK2wJ.FEnX
 tD1fuFkFxrgQeIZLCz9mGM5oVKsywDdQnDnaLOKVOtIK8SdAbgjHN7b6ZAiKFbzLLdfl3q2bMaPK
 yFVkGUiU3p_7dValN.LY_zDJGUShRXH90m.6_Y7E9ivJ7ZiHB2f3awHaWGVbVt1L_907QiY4SefR
 Esl89xIx0xbbncvfQ6Wm7wnq5P1h4IW_622IIdzVM9oGycGXf95KmLgU3zJ1NZrDBhq2Me3AAYhE
 cL3wv8mnaQTzWIo7gOnPQKm2FcXtzPDaBDvi4bHfbzyoNy8IZabsLIPq42yjPfm_LZt0jZGrP0bI
 EDtu_B9WfT3shkxCAxHzmurHtQKVd8zKs7oowk46oBddjhjN3xyjBQephigRKZVReAtQzoCxgLkN
 QSQ5Mkj_Lcu9UxkY9Mp3z8Ck7fNSM4c.fesB5cAoxCvsvHR1kAXAuusTsvAvsnRXPD5IwiILGIV5
 jAPJtbTFTv2UWl1.ZT_8U7q5BlrNNxVRj8yIi2JDfz8wXe72YEmTRvsTXbhlU00OtOoM5tHzkMuA
 TSWZRGVYFR8qfod.qeYusQzoNsSDpfDcq8t5Ygn2vFBO1bLfZ0Kku.jjJrR4qKRm0NNy1TP__wB1
 Ux5HDkKsrwGS_bHraT8cHKEdQqCPBfyTQBVMGQcyfpcEW8yaSh0KpEyo.QiDEr8_3GsGNoXVRwV0
 _AqeZvNbPDkD5pbHiv8MbXmX56Z4TVRhgeZeDt_DMUGu_vJzAVMEXlfCoh8p.9lGg2UI1kqxFZl_
 YCsBOviZmJqFbupmVvMo.UhnEcKB5pLVEOSk2KXP4u.zTjjgPhkIQcEEp8mKvH379QFGS_dWR2ct
 ewNVmd33p2MLbflc0750ARl5FLNmTmC0MJF8cepvHaP6lu2n1_S6RvpceYxM.OAsx56Rf29nJ.8Q
 awwGgYDylt0T8XG46oLM2X2mJofUXjIsSAn9Rh72ogI3LUAH66XekRhbTqDgCugKn7C98D.I.wHG
 I8Qq_LrUvrYxH04B.46GJj35Q.IxStMd0vpaAozJ3
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 200907be-8b1b-481b-b0dc-cad3b8bdf600
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Sun, 7 Jun 2026 13:37:48 +0000
Received: by hermes--production-ir2-89844b765-d82gs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84a60f0a442754d82af3c3f91ed8b6cd;
          Sun, 07 Jun 2026 12:55:13 +0000 (UTC)
Message-ID: <617aa489-4f0c-4fe0-8cf3-55c98f4d4d9e@yahoo.com>
Date: Sun, 7 Jun 2026 14:55:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v13 2/9] net: dsa: realtek: rtl8365mb: reject
 unsupported topologies
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
References: <20260606-realtek_forward-v13-0-b9e409687cbe@gmail.com>
 <20260606-realtek_forward-v13-2-b9e409687cbe@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260606-realtek_forward-v13-2-b9e409687cbe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25918 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296240-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:luizluca@gmail.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linusw@kernel.org,m:alsi@bang-olufsen.dk,m:yury.norov@gmail.com,m:linux@rasmusvillemoes.dk,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:yurynorov@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C409650A69

On 6/6/2026 10:29 AM, Luiz Angelo Daros de Luca wrote:
> Explicitly enforce the presence of a CPU port (-EINVAL) and reject DSA
> cascade links (-EOPNOTSUPP) during setup to prevent silent failures.
> 
> These topologies were already non-functional. Without a CPU port, the
> driver does not activate CPU tagging. Additionally, the switch hardware
> was not designed to be cascaded, and DSA links never worked because
> CPU tagging is not enabled for them.
> 
> Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
[...]
>drivers/net/dsa/realtek/rtl8365mb.c:rtl8365mb_get_stats64() {
>    ...
>	mb = priv->chip_data;
>	p = &mb->ports[port];
>	spin_lock(&p->stats_lock);
>	memcpy(s, &p->stats, sizeof(*s));
>	spin_unlock(&p->stats_lock);
>}

Sashiko reports a potential deadlock around stats_lock, however I couldn't find a call chain reaching rtl8365mb_get_stats64() from softirq context. Can anyone point to such a path?


