Return-Path: <netdev+bounces-286306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABAsFI6jAGqTLAEAu9opvQ
	(envelope-from <netdev+bounces-286306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:26:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DAF504D28
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 929DC300D461
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2932A39F162;
	Sun, 10 May 2026 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rP2kDJcQ"
X-Original-To: netdev@vger.kernel.org
Received: from sonic301-31.consmr.mail.ne1.yahoo.com (sonic301-31.consmr.mail.ne1.yahoo.com [66.163.184.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827139B497
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426753; cv=none; b=EtVrd9ijEpaZtczHGH+z259JaFXKOwRY8yCb6b/3QAPwRzfpJmApHFRYOTdNTpfo49nGkgbO0h+5ZBZellzkz79Exedh09XGxBQgX/jNYRQx6Y5MR2nbND+YbwM4yqycdSxWc58Nm5Ff9NcGC8YteZ3NGRRRdUjKBGQxYpDkmik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426753; c=relaxed/simple;
	bh=/ehoFFQNfJiuhf1xK0B+pHZF6KL46DEqwSHr/BqMsJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GoxvorHtZd3CIYBoBCh+xt2ZeUNpGc0Dfl0xXRNZvTosi2evwTR87zNHvy78mFpDklg8/sFfWDtTuQuO4CzYuMwWKfpEhVdYofrf9IweJelWqvG5NxS5A/0Miy6OhbfvxL+/X5CYkAGnu7QSOxQW7L6I90R7m8g30slV0s8ezwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=rP2kDJcQ; arc=none smtp.client-ip=66.163.184.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778426744; bh=UOrLczsaI83urU62LuO7HgDOSFQNHln1hwd6iXa45tE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=rP2kDJcQYqPfnLfbV54STAD2FW//IWGI2Tc+uoSH57rTvishZyzPf5zGxh2HH+G9+BVHQInrQbknhThHLcwKrjVSvpHOOZyGSqxFguBet1V+FFpafdFV1f7uuRMEb9cTa213L/AmvLcO3acGUIckpM3ik82lvfD8Dr7xztRWcJrhQIY9aT/yH5aUOMIATzgcy2w/HSYgBEOHm8tNrvCXKocIT/YAAMcPhxA869GyejNCZ0u4CydKwsWZmnZrZqz3YFswQ9KUKnWq7I+F7Qd2+MX0X4tpon4Y1ZlzBBg4fvWcHFYd+1qgVg0VQdT3qtijm7H56agVB90wgoVY3s0llg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778426744; bh=ikm6evrz7hBFlUY+zwTqwTtq7Sd4QOf1+1NEZbrqhR2=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=pvapYAuHZT+7k2hMVamEgelQW7rREbAdB9krFhrpUDhgWqzFX8nXOQxzHyiq7pxwPW1yitX1RSXvzRd8b4Tacvaca42UUu3CEGbJ+zfIImLXBXpLoIA9xAFo3uzOM6u0XY5YgkHW2fevD3WZIfVCwZ95anCXmSvdap6evNU7qXCdvG6Cft/W26SB9AYUQssJvuVJtio8ge5ALbTwfGg0UjX4czwYBwlDYan1FhkQwZq8RHc9/akrUhObk10N2BvJxjqihXmLXOWttL3ioF0O3N53bCk11CdK/mpxSxbxlNXNEpSIDbOUqErvrrvvZN5bzOKpDGU7EYwVTTxV8qsQxg==
X-YMail-OSG: KpeBUdwVM1mlghuoEIjmm3AIgchcgyi3wIuzNSmZrDp0EX.vKmT9vwEpVyGD0WO
 WtJVcOKHm2KxOO1rOO0jbMBoRXLw_afHeLuNbTQ1ggtkIt6Qni67fGTdUOXmS3VGXyPN.y4hlChn
 QJdXD.raO25csirEWy5O9WAU7ig_oZL1IxNQmNycZLYhCCVtpurw2N2UW6FeR1CIzgRJaIyT7ojT
 5oWFpNXbRGo8LXaprpoxUV_PFySHiee.U8IQk76ukiAj3KIZdPmRMJTsQTcmWIwG1JN7BlkE0tCz
 6dn0a7jp_R71HzZBcsZkgrlD9Doz.yZrQ9hAJ0ovI4Vxw3aRTAxf.AsCRQDmWXoht7eL1HNRgIN9
 Ne8gGRDfZfJnLUv17gsclcQuUtBzEPX6XSNl4.l6VfJRMGLxKqZlyWjAsVBm6f4M9ai7uG9HCRKi
 OQtwBF09vcBDH2PzcDmRMj7t9SeLZRvgY01Rue2oDIWDX2Feel6JxHI2JzIGJTBHoDsIOIwmHlkh
 s.cesJaEJwCTFHdlNsOa5A4twfO1GZzkUQlM39BTCxShLbQIHIWAYojBw3uDNim2QcmZ4Fu.SBPp
 tdQKrN525hNw1BqOOasrOSe_t4JjRRjoRdijbGnJtvpcvVczRSwLi_d1L2kIjykjth92C52YKduL
 GGGFHGnK2mHVOcm6aNnW3YraPxUya6W7_Nw9GlH0jpciWx9d1mEEs5fcdfZfNSlPrTZYZ1eCGMAU
 TyVDZnCnZZbn.iD4rwwTnwFsaSBHzZqWCEriKZ9jx_bvbz7FN4SJyFkVffwdv1ol.JR1YUUayTxp
 uMNQKb_3BgtEvUW3NOQGeSv4mkcCeo7xn1LX_VkVcYzLMqlNIB3TxQFFw.HEVwnxK5mdKcWzVmk.
 kZ1gk1HZyDoYOQkXsVvj59ZCiACy2h8xxyY3JqktCw5hLu0gpcblHJ_ZnwT0MiWoTi_TvU0lxjtb
 xjjxfQ8iOe6LBGMpGF6NGSElnAOLFFflwMFgOf8ac0JNLcZs3x.Yn0YGpy.uGFfL68oQTMKzH8sd
 sqaiFvrpzjVQf2vA1xv7WXzSO8uoETovov6s8oEeQA72mHd2e8vCA9r57JXOGW5qOpbpMsErOVtL
 0cTatiiScoHkKjDzcpGQ8WCSqGcaxr__LtTWdSgcC2eli4FyLDJe3lxI9i4VyoOfedas4wCV..DD
 gfRQmJ0KlTOkNCLgEQlgxaAaOyWMZiRYRyrASR52AePEomuCr4SK2fzwTxtCxy53k8ZhH2qPfn8F
 _f2gw0pJ6UAUDjL3m9cqkOPilX_EtgUa.e5FPw2GRlKK394qfJ0HKBCA4M9pnM6PymF4Xty6C.Cg
 xzWKiG9aoLwJtSVoiInX9DLbLBQON6OayS6MffrLkxhU3TlQiCviA7Xp8ehA97FXUP3CZJkbyuXG
 6rfzN0MDbev0YA1vBoqU7_F9YknLTDpGXnX0PfQFVbqcvUSh6zsnfQ89xNn7I00BGQ6M5GlP8SSo
 .Quppe5TdNRFpLPbsAwNEfUG1KsWb4U4Vmtm_zPYTeh4ymZ2fR5.Kdn8WXxl1kfb.nkEs55kjzOG
 1NV8kZDhL6sLB4RZO0HFLKFnMlvrfX63d74IEUBXOyru9ipw8Y.METYenvizG09ZX8TSYT0Ld1Qa
 GmVWuo19zTdnKQbaRusLoPxR5pdu01Nv4YOnpkXehNQj9BP69h0myLexgSD8Izj4_Gl9BghpY_xg
 ZpclqDZ_jk.oRlUtG_PU.ySheNI7oGWNTn78hPGahud03nbloGOSRqAcG5WjRLZBFidgB9gDo9y_
 6wVkd_ZYEGJ37aZiTqwATt5IB.Q_ztkoCGaJpoUCJDRW23t57q7saYt7SF.gx6E5zQGXqXMIOylu
 MgO5haOf6HtCnrfhCKj2V_y_cQstlWW8xjG35duaYiaXHgfZqCfmpXyIqtW3jbZIQlFQSLFBQT4I
 WEpRxcu290NBXY9XWQVSML6QYugaKoErjUvC.INkJx0iAFXXkFXt6fOntdmFG2qMHKOnKa6qH5u8
 5YQs7An.zLuBMHmhIM8omYXwkVhIhl9ZnffM1MDEQ7X41soRLAe7chrUL5s6UCLFhkBKoecfL7Je
 CCDBx5ivBmGGv5eRpZbFGitmsCp1L1B1Jjm4H7bn9Wwij4842JiEFH3N0HKixcT_9iBB09dn04Ju
 ltjDXyzd0eK5Nk9rUWX9ce0by2Da2p4vH5CqTImq3LOSfzwkvFxIOyKbkV5I4dUHTrZ_b13aqAPc
 RFQlBqxAPi1FxXgsKE5RFhK1ncEqp4_HChaRJ_Xt2eqijgCcJR_RysC_5yrqMOaWRulImdeMyKGP
 jvtem8e.PRvzYqWIZhds38BNHop7iMso9O0E0WacO58m_pYpJhByMK14dzQ--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 1f8f5251-07d4-47ff-93ed-8551af5f585b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Sun, 10 May 2026 15:25:44 +0000
Received: by hermes--production-ir2-89844b765-l79qj (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 84d8b14dacff16e4efb261ae91e2e501;
          Sun, 10 May 2026 15:25:42 +0000 (UTC)
Message-ID: <d1314927-67c3-4fdc-a6e9-444eac546fcb@yahoo.com>
Date: Sun, 10 May 2026 17:25:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 7/8] net: dsa: realtek: rtl8365mb: add FDB
 support
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
 <20260506-realtek_forward-v3-7-1d87c5f85a3b@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260506-realtek_forward-v3-7-1d87c5f85a3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: A9DAF504D28
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286306-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
> Implement support for FDB and MDB management for the RTL8365MB series
> switches.
> 
> The hardware supports IVL by keying the forwarding database with the
> {VID, MAC, EFID} tuple.  The Extended Filtering ID (EFID) is 3 bits
> wide, providing 8 unique filtering domains. This driver reserves EFID 0
> for standalone ports, effectively limiting the hardware offload to a
> maximum of 7 bridges.
> 
> Introduce a mutex lock (l2_lock) to protect concurrent L2 table updates.
> 
> Add support for forwarding database operations, including unicast and
> multicast entry handling as well as fast aging support.
> 
> Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

