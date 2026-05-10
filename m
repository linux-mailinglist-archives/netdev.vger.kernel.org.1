Return-Path: <netdev+bounces-286311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLw7Ks+lAGoqLQEAu9opvQ
	(envelope-from <netdev+bounces-286311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:35:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E05504DDD
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8583F30080A9
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88DF338F639;
	Sun, 10 May 2026 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="GAAYSimy"
X-Original-To: netdev@vger.kernel.org
Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9AC36AB5A
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 15:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427338; cv=none; b=YLNe28qg9h8RW6wi9GwhHMGNK5j+4OdWQ46Pgkg/pLXtMKn7N/8lYNzomJyNtYAWE7Cw+mBsmxOTQSYus1Y74IH1uTWB8Q1EDU6KeVGeyQifv7pbBjpwAfo3hbb9K7rZa0sLN2CdVkMfu3kulXuF9Zu7fFuFz4KOPXlZAm1LPZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427338; c=relaxed/simple;
	bh=ZdPVKTvEDf2zWQFzmDahbpk6Gme4W/LvyXQlw1mrObI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PhjNqhuuVFD3Ail364Y3SWEqCskwaOKeYBF8H8xN5vcfbvHnESWmyops0+J5BTnIXLPN6N4K4aem0L2nYuXy+nd0kR6TS10pqBOIpInh+LM0w5Fg+hXo2U930eiO/kLJaebKGJYFa54SK+In57YbJsK38niDx02n5Ef4XX/c2Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=GAAYSimy; arc=none smtp.client-ip=66.163.184.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778427336; bh=8sqbTiDfRCdIRw/zSRUGVAZpMYuptADYo7ydUABdxxM=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=GAAYSimy8+NVE36eF2HBdQrm7Y6weIRVXQffJv4/6ziGYGg7giFWF0DgJ3+s4SEtbNgVbof7wGj5qV8wREPzJwsKoLcwV8aydHhDj95xHw6pGHpFADxflKYc6oW+x1UMN78DP6g9TItwLSytbYNeSWd3w0JbNXJnNRW8bPJPuGpRlCq21wmlddyToSLVhzfqQc+p3c4cyM9EYcBOkWi1maS8klXiq64nl3Alm0dZjOjrVB/+tveOlKzIvfCTyd6cIGZQceo88a2usXqANUrGTmTNyE+9bc00bHMZZqXfgnlNBoi6uEobePlYnaq80J/pBfIh1ThyJ/GfNQLYrVe+DA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778427336; bh=wdSECj2YVLnYTx7fPTbTZrN1pdt0q1AeNwZg8iSXnRq=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=L3oQdvGuDyfrN86r0bFqPbq/S5b2hxSEoFHETlPHZ0yz5DrKRmpimYseX49PDen1Uyx+TlK0iRYC9IS6X7Fb/sDise5Um/2V9fvLX6tqd+UF29OY7LEogtbppiDVAnbxA0W40scQYf+yLp3O1ENrYIiqFAPonAGKeAITS/UnRZWmxZHv8+WVMMuQZHMnaCKCi6XHC1pPWYwprcjuZwCYACmZfDr6mIVPh8hUlcZv+ag06N4bXktCzmnX/Qg4WuWivsd7/+Mt8mdIfvqLeU9IlbpxZaom81gKIAZpnZDXDGV3+I36a/LszH2VRjnEKaqE7AKHcxOgPXXxD3eUPlkjtw==
X-YMail-OSG: R1NgV1oVM1kV.WMYbTH5dJu1o3Gvm4H8X06AH2e4saWfH4ppg4NW2opGodtmHLa
 TeQUaSSbrFJAoMSSAKzXrqecWGQpw3GhbwopDmNty4V06dkQmzJbEDT1bOGFaZLilHN364VcfpBx
 IcXh1ihTdRG1ZftnA6mePp7AEj4MaREggSfqZpmvUpJdvkD92.3BsugKAbAxnpMYmGkKfRHuqB8O
 6zlU4gObpJHFN1fKpZHAOhyRpL_D2gRiRJZLHgX4p_Xkk1XNBQb_k3bCcWcDajm7J.7.eD_d4dsK
 myPY0cPidOms07szm9iCvb4mwv2zAAUqQTq7drOcfapmfvxOgKvcRMiFBWokVZGFg9PIEAL34Zfi
 qhQPqKal.ZjAVSH8uPQnphWBV4QMbjqzfyK6VtMSWzZw9ARmcPkMFwtQrhFE.JZR1.GMv7B_XG._
 Mow1qFlHASQVs9GZKbZYSG8kbCNw49zSZMpFLVwGnbTguYiX4iVWy8_f2gcdfhkyBVunH74v53h6
 qlszUjQENx65HthgMvoJUh7oImch5Iwp72cpY2k6Tu.1F7PnJ8uCiCvMXgSWft4YnXdW.rgUC9_q
 0USDKkNh9dkh.bI.T.OLlQwEQTzZs1mYyBtnLoL4ApHvV1BOrA.U7uKIeuKHsOAXRA1NbMzDI.eQ
 ci5vy.EskFXFYDL1MyHI0.J1zU.LxR88_nvK17cq0ydLrmd.BLmLkHdn2kBuhxptkEqjcpQeBhJB
 Cwiknz0PyEfi59ZK06kjZw0X5EV7QQEM1JMxjsgYhu6nSLuFjhrJgl.l3GjqaLikD4duuK9gSCHm
 TGJFj9qbKhJVrCr00RugQeYycHlZPxkgRdd3Ts1Q2Fjpd9jAMCVCTla1SMOA4dEISgMwcbKa5mLU
 Bg6jvCPdvw8jSPHrQascOCP0NvL7lga0fUjRpfnmc1iew9xiNjbk98UsyNmx.EZQKwtxYHu6cMD0
 QbJ9uYxOopstVetV_GLFi83cgII157yLZWYxK7ZHX0vRnSU7.0xJ7RDnquJybjX4ZgyiXqp_K1_a
 EQKmMC.7reqHlHZAwWIYgyDyLWiQQecELSh0AoS2bBrQ9XCla4GOUoOB9W2EKeyLLSyMLRqzNqCa
 kNSaXSmC6GgU65PtXMFpHJvUuWERaoAXAz.yaI8uu2WuipQ68ifqNrKTfm67L9y9Qqlr2ImAmIAq
 TyEpQ6wAW_XUa.3dlYJR7PU9DMkIsd8vuz4MWPRco2SQJB3DKURih70dVQtPdDbJBcr1eGJ7UWQh
 aFdbtOCkTRipPyCw_S3Bz_sqAN405Bg5_GIlTTQWjCFGk6n003k24J9f0tLkh880S3rj.FaP.Bfa
 _WOsptxgvEwX.uk8lEjpFKyNQqZQDl.E2iZQ9Nyj0HtekVlu.D7yQPUqe5zwpVR7wyeLXn6mdaiH
 DXE7FAXMLZlrUI3mDvoH5trCJ5nsqzqdSpWYRzVIT3cYdQafeXx7zxULWayRojqnmBK24nljbgIy
 _mpMtlSAcVA7sp9Ix8nn0WeEBqhNBn2r5YBYpeAYsiD2QEICvcds2OVrkGclEyTAOy8CiCOKyg5e
 0Vf.VoXjDjcO7oWgkRwvWAMrkxWTeGDwPYT2qJcn67PamIowCEop3mw.w0YRI02FCFsjgkWRqvD9
 Zh68OwS0SnqrAQEpLorM8nkufYQa8ptoJsKe6F8IyzSIs.J8BiqZ1XU5JGeSPPU3uQnQrvoxIZOp
 veF_pneE8PQCi7nECG0aPYqSgmAwbSUmdkWW8bO8Xx7cG6E0iOVGfvldouPLAgwlOKWLfLxVzWZP
 V3c8AbksLd3UgG2oK1.R8XQmhmjiuGBsDUjFL3knnL0WlQY431r5kPgd92CVcKqSYBd0DvyTiuzW
 dvyCwkgQAA3Z2tqZ3Ogwizqick94c2Cm30f25KFfsrhll9X4csQqLZo5AuRGoP9.Lb3U6oVNqwtD
 QyQrG4Qvnrprph5CrEUIKu.nelJAh0O9Lo2J32HXl5EGs22C7Xxh_MAmsL2fTXcIeQfWy9mVLnYS
 LGwBz1QstVdXlk.tcMSb_l44WTfqc93.WqEOqCewPGpGUvUozsxnP1MucBVa0qJjeUuWupwRQO5y
 SRNbaB6NuiETXHl8wtN7QreBHewMLo.rQzq3HVqvUAysKoTeEuU7MC3bE8FuOqb4F3SyFyQawUsZ
 .8TYkxDLUww1pHKzx2F4.HQ6Lu5UVLiDLgDRMO3D1RH3gjG0AZYgz7WLmjr1q9abZ_LAOP3wI6na
 q3V0CTcpyhfb434RmjAqgLpxPxholLbgF7e8gQEcCT1PTi6RBIamVLHpPzW6Ml9klyJNaij9GHXz
 O4RZQ2l4ZsIhmE1QVrBSI.VZG1letr8FCXyoxLUQb.7MOQ5ukTw8-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 52eeb4ff-d47d-402e-981f-c69fa0b79fdd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sun, 10 May 2026 15:35:36 +0000
Received: by hermes--production-ir2-89844b765-8tkrv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID b2e364413188eaee4ab9489096f727d4;
          Sun, 10 May 2026 15:25:15 +0000 (UTC)
Message-ID: <70b04962-2d32-497a-93b4-4287f394f44f@yahoo.com>
Date: Sun, 10 May 2026 17:25:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 6/8] net: dsa: realtek: rtl8365mb: add
 port_bridge_{join,leave}
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
 <20260506-realtek_forward-v3-6-1d87c5f85a3b@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260506-realtek_forward-v3-6-1d87c5f85a3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 24E05504DDD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286311-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FREEMAIL_FROM(0.00)[yahoo.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/2026 4:58 AM, Luiz Angelo Daros de Luca wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> Implement hardware offloading of bridge functionality. This is achieved
> by using the per-port isolation registers, which contain a forwarding
> port mask. The switch will refuse to forward packets ingressed on a
> given port to a port which is not in its forwarding mask.
> 
> For each bridge that is offloaded, use the DSA-provided bridge number
> for the Extended Filtering ID (EFID). When using Independent VLAN
> Learning (IVL), the forwarding database is keyed with the tuple
> {VID, MAC, EFID}. There are 8 EFIDs available (0~7), but we reserve the
> default EFID 0 for standalone ports where learning is disabled. This
> fits nicely because DSA indexes the bridge number starting from 1.
> 
> Because of the limited number of EFIDs, we have to set the
> max_num_bridges property of our switch to 7: we can't offload more than
> that or we will fail to offer IVL as at least two bridges would end up
> having to share an EFID.
> 
> Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

