Return-Path: <netdev+bounces-288650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC74LzmSCGrEvwMAu9opvQ
	(envelope-from <netdev+bounces-288650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:50:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6993A55C800
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 17:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF8A330054CA
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 15:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292B03E5A13;
	Sat, 16 May 2026 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="br7ODEfU"
X-Original-To: netdev@vger.kernel.org
Received: from sonic315-20.consmr.mail.ne1.yahoo.com (sonic315-20.consmr.mail.ne1.yahoo.com [66.163.190.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96103E5595
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.190.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778946614; cv=none; b=qbKXro8X+CbLpVwytpOgr9vZ/odqG/KTNRFv63hBn5zRPjEFET1gf19yLhdz06yB/XghIH2/zH62jC70YZBc2l1s+RPa2LsNYpkRNU49Wmx/6xN6beiFByB1G+YLHl5m3WQViKAbjpbjiHllhtKVgUjn8QNSpbz8JGnFZdGAVWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778946614; c=relaxed/simple;
	bh=GdS+M+t+cPithYukk7wR37L3tjoMWmVa0i6HiZVp6dw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjDOIrKKOWbYnQ5GAeUAHsEuCVqbRnRkZ/j/BJsObLi7y7VHLs2gEDe5PnSI/LKOk9isF81rPaqfwxpxu9IUUmC1+yrKxPmPtvAy24/mDKNr4bueb34gLzb1ilJbMgL0jTPeDSKIqadahp9dSHFxLany/rdi8vM3f1VXfoFu7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=br7ODEfU; arc=none smtp.client-ip=66.163.190.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778946605; bh=KuJBcxaEDzhej/1Dif7VlzpgSH3gyO47SrTVlg5EJvQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=br7ODEfUxwS7VH0dBe41SCoUOF3wJx+OVSzaXo1uJ7pXZt6GfbfBdaMZ5wnDgjIxqCVbiZRds++qF03I6F3febSXm435Ijk3q3TNcuO+Zexvh3FyNk9RuD4ftZ1NCjlSqH1kGGbxqLdsbwNOKY/5bgzwu9dDuoNKmS++qADiVQGXjFMSQMg9s0rZnb0ot5oHSMlMut9z2wMYMeo1E7dS+hM3y3jugZsk6Fjb4RHLVMQtxB9gv6zoVZVkApiT4maEqBI44peNoVGtDTweoiUmv5ScLm9kWHXR79iwzpjnyDQq0V25By5OkTe/OUQmZY5IVbud6O8ZDdiHWBC0WAxQ2A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778946605; bh=1VT4N0tOkFEquW3M8S8Gg/9kbHDY5ro+Ogghqkeg8n5=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=InC4oSf6tb/8/f7yJUPTwLRX5AZi32GDi1HLLXYwH7mHrXigGz2nXrPXVR78NInccwhUm8cOE1OhMJ98o6ZXFZwb6CFjfvZXjiouGLW7Wm9PONNuju8dh5+TsoBXJP9P+okEqXtZ4W1uXmR8Pe52WQ89Mx737Rz/NvPjJ2dMCYQgoY+b8XTX8TojYdrGuru5PWZ+pwA5OiIit2exQqxEj6l0jptepaXmPm/NcQpHu+ylAyqNT1N4fxpv8hvAaPdE8icsvBulpGhxmUzvTb20AmBXJGiEAC/kW8evM8q0ouK9bxRo9BfbWQDPa6AoR929uZRN2jtv4D0OPfDRw4Hfug==
X-YMail-OSG: naZPgFUVM1kb2Dh.NTX08tK9gk7bHlef5oYgKEvD_kTFe1.oud1BbIOvuAUeNxx
 hPmhmzcQiWXHA70IvIrUk1L4tvElrwy8ucVqC2y2Q9DsJGWcc27wpdBaZHa9GXKeTxNCtQS9257c
 k1ziim2D526CD0FckzOg73FX8Fef449k4jaDcSk07x.6iHH7RY7bA6R_befCNuk1HOH32ACwX4zZ
 3I_NNIpTQNCJflrF0LcjOuh_CG.MjInnHrU2IKodJsox4uOLY853ISV1GY7vDgPnAdDsrzqd4SSr
 eYhKdKObTwnD4WNS1iJXZpdG82cZwM_4dzzLYV2WYtaH2JnCwYmpOVa_FlXS2xkwNI3QuRCAiQvI
 uehwRH8XwZ6mEV2jFUYjGI327Yh.S9EIH7hNG5fRummB2sqoIswQkmjOxad_nmUkXOFgnXE8.h97
 tnmrlljoImqFyURZU7quCs6UO2_a1tRpcO0q.r_NTjMDZjFRjENDP58isqDUobm5TmojFanpIY1N
 c7zepawf2mIeWM7yGLvdXI4x.s00XNJ9VklZ6oudJ3sIOEZgRMmFgeuSU7HWv0_TOcjNteMWChqT
 uUNG3P3oaxIx28oY9C7r_Jte42cTIXDNsMEQOvDmKEPeiO9BKzZ8E3LR2d5GBx4_2zgnVvVab7KY
 aWNm_jEl0dbLreJQneyC3sDfUwdZZjSEgez31jnFTW9k7isVoGUqyNe2i7vyKFUPZIxjaKX3ykKh
 2W.EUfUUxZ2WU1Ow43tO5NhRkn8DHV8Nb1ugFabTb2_nF1ansxmepPDwQsI5egCh2oRJaS0.ESI3
 W9tCGLIZ9FiLbFWOF0AEjfushYrNhKgXEoWxHPaTzAF.c.06Fta1uS5YaW9_VwUP2e.pkE3L8pAr
 _U0FTgXTtcp1d1sY2Xpz09n37H12aKAaUmB.UWONO4FW875Q3W6GgRFUiqkzPy4ClVr9a9ZISx0M
 0BstXNj3wcZIVThmkypZn5pZ_bV1PIKRVfLNHvfrztyBw7h4W7O.oO6M1uHoR4VvGPeFf1tj.Xvg
 TsAaQpidmaHA6X1f.0s90mISYBMjU8qg5TcXnC05eZIrK7L.ZmN34RLNCr0qM0SE6vxarNWq_s.J
 UcXff6NDcXgj_lYb08edIeki0vV1C5Jot_0n4qpOgUbqogsy36taYARaevhywjqtdbBtuBEp8e.m
 kdUTheN1r3L.AMurmSpMzpDYtM3Y3JWLalFG5FEeCs.ousAS5xTK8pVmPhggw6JoLIwv3Sb8Rawt
 DD9MXzi1d0kVRO7BSxR4gnLF5E9AB3UKFj0JMrHbvp5FFYJyhWuV4Gcz0eUB0OmiCcyLYRRZ4Ph_
 h2Lbp0iUIMByaJojAhbM4FEJBI2Pnj6_T4Vv1.wyyMn7uSbPZ33zsnfDkUaUFvVrjRaxEjSUA0Ih
 2MGxhqHB3KjNrSQrRYlOu._kDTrQACivg9_s8efzEHGg1FGq0J1Wctr2Wkw6EErAaiSu1XN6f6e4
 8iMnLbUC9udt7HKwr8DVYt5mTvf2KrWdU7MzzFAOR2WGenk.O1Y27f9iRiTi3D.CzyZUi0OfsPny
 d1bn92c3yud34GlRfiCGGHWhLd6bKf_s8uJxbe81gH4Spy.QQ3HvWEk8cck4IJUCQWPac1Qy6UXG
 GxhxgHE_Ao7sTZRVt0.2Kg_zzd3dS8yJ0Cq8K3zeW1h518CH3iCS8y_h6uH44LdDk.RXMfXus02_
 G37HK4Womfjb.hmJwN1mKEDizRo5cd8bnvklx._BZRg.iIX8uWvC4ij5KKH0rRMjN7yA3wZPgIWi
 RoivVzbW2wmKrCNdJWdytR98AYR.FRiXnYDjxVLzEY23jBcf.a5MiSwW.CVmfNjJhL8AsCWoDKI7
 Ukm8y26VUboG74ZVNmJjSIlhQ_T0YMlR7sw27UOwMZx7MxHlfUeI4yf0SAaIv2PkLNYH.Hav1hHx
 YUriFsxSs5vmRfOi2bkYanp2jDqDICnpWS85QoVeMwr3xcmGjOFVC2l.YqgS7jpUjDXilj5O3s6n
 CmnZOIe.qgc01buHRJhBL60ogsoesUwmcUr5RvKg86xoqevkFuv0DNGtFaqoQUbR.nd42HZ9A9aW
 2eQTFWxMwolkoqr7b8_8VZ1J6InVVQRZd_ZJWcvw5QFqUvTicxYqoSONXxdeF29jGEEquGkkpEmu
 UAaIADKY8gYv1ie7l0ryH7PdT5vHh1GA0noyl282G1pZFHrTRaZNi9QnNdTgGMfxyplvCj8P6Ov1
 IWl8sqYWY56NKhB41K5obxQDhE6MKgHYJPgbEKmiyVZKlWCl7knt9boVxv8vOy2LBHB8SLYTwnDD
 haYm8DyfSthg2lWod.9Nq2UW260JvgurcSLgQudnQjFZtUA--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 02bab310-7416-4ba2-a908-8409510741f5
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Sat, 16 May 2026 15:50:05 +0000
Received: by hermes--production-ir2-89844b765-fcdgd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID d1fd088fae3fb730d644c622fe561942;
          Sat, 16 May 2026 15:32:35 +0000 (UTC)
Message-ID: <0bfbe564-66dc-483d-a031-f419beefe65a@yahoo.com>
Date: Sat, 16 May 2026 17:32:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 2/8] net: dsa: realtek: rtl8365mb: use dsa
 helpers for port iteration
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>,
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
References: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
 <20260516-realtek_forward-v4-2-8b6d6a1eefdc@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260516-realtek_forward-v4-2-8b6d6a1eefdc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 6993A55C800
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288650-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/16/2026 5:46 AM, Luiz Angelo Daros de Luca wrote:
> Use dsa_switch_for_each_*() whenever possible.
> 
> For port setup(), a new blocking setup phase was added for all ports,
> including unused ones, before the user and CPU port setup.
> 
> CPU isolation includes all user ports as traffic was being blocked in
> some scenarios (suggested by Abdulkader Alrezej).
> 
> The driver bails out if a DSA port is detected as the driver was not
> tested in a cascading setup.
> 
> Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

