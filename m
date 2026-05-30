Return-Path: <netdev+bounces-293321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lsoIN8OuGmrg7QgAu9opvQ
	(envelope-from <netdev+bounces-293321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 11:32:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3553B60BDD8
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 11:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12F4D300916E
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 09:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD5338F62F;
	Sat, 30 May 2026 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ygox93rj"
X-Original-To: netdev@vger.kernel.org
Received: from sonic316-22.consmr.mail.ne1.yahoo.com (sonic316-22.consmr.mail.ne1.yahoo.com [66.163.187.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5F3391E7F
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.187.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780133473; cv=none; b=bVafnrfWkkTD2iSS5U6TjpN3SffjUzkH3gyW+yoPjJFCyX35TaAjq/ZIpMia1l5UUNldseU4iBl7JJX3qIiqSS9VJnMFK1PwvcxSR6J7FWvIa7B8Dj/b8YDN+601uLzhGi7ERaXh+1lMBSJpD9GSaVo273GJ+OXccI9pZkbzxkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780133473; c=relaxed/simple;
	bh=atD/gSnPmneU4ZxcauOhmKWIZctrbFu4ci1ja844yNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDMZB6AXno9uPKeKMCrnbR9cTWj7xU4uRhw1n4VYfF6WP3FELtbbiHqv+Cwl+/4Ls09t+CpYd7CG/YJiVjZd+rTNfDz6wsN5178Z1UzOmpYIrxzv35M/sgIx1ZYFaswhi3722f5t4vO8W4IHl3DIxlKdncopTWroBVfflQ5MsMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ygox93rj; arc=none smtp.client-ip=66.163.187.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1780133465; bh=PPe/LxstChGTwVBv8kMEkJepDI6lxZiORRB302pJMuw=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ygox93rjM6QGVTxq46gpMyMTjBpo936hXgcdC+BI9Ak0bRohnMJ9mSFBWhfx71hZ7AxpKVHnNGbPHzDROQeNUJlt69jeSRmBUBSKgYrsOMmZTAXJIFO939AXxHU6frF/7zANTTxMsikRfnLCQNB7BG5b5zTpbp62+pidRyiZiDqJGu2Tmrn/ZIkazBiMT/55v1oIDexfO3ZaSa/VQOG5otqOy3Fp60ggKyioGtdweAtJtHTUFzQy7mTW1oz43P7gixtrhoH/xB+xUdyJZHs0jiaYuyJxp9bxOs8ZmWzFAIP5gvlFPA6+L+COSYoN1nGZnJI5Xkrm6WWwk32/FuhDrw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1780133465; bh=W3W/eTUyJlmrZbA+52uB8Rr94E5hyMkgU9D62HZhski=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=riYtmOSFpn/zt2GQ0GnzJpaWS+3XnZbVpclyJG74yUMcXiQVxix3YxMFruLorm6wJraCpkLNr3v55wGjsFKeLlVzX540TJwI8ea1uJOTjTtoK0UT4VJbmSfPWI6yvT95a0Z2EOo2atzjwtNW+XSXLnpfybILeW1tx4le0D5Av45Nj0h8azRaAftvOCI5PkdFxC0fO8R24JTc9t9JnfWpgOo/6D5+PSkCYzkv2gfIDPJMYi8OECKel0hVXzx77boZd+8NX+nW5wNuacD1hFnWSOKXAFNMfBkfupYoD2dkKsyMF4LNL5U/X741I/0pdKNMhFKlLd7vxGl7Q3Lb5SQ7NQ==
X-YMail-OSG: Oq2I1MwVM1lHqc7CWcPWT9FbJ7BTa_Be8udq8xa64cwCExjfhZuJzhyNAWoX1nJ
 JiwcUOKrT567SgKJE_8JxDLWS.dVLXWhF..zStplLQpmvKRGH1SodgZYOSS5wVakEdmtXt.fQ_sj
 rwnk27cgfePaK5u5x7ieGmcx4mz95TXPp5anCPLpR9HCNqHSfunMS56L_cp7b75L3t2QnLRfDHOk
 dIHN.MFElADk6T4L3VcAhUSlINUs4FHCvmMO16g9yvkiAeuR9OGDXTZ2Fw8ia3n4f3pkDdN9LdK1
 0t46fVh6roRh7jchgRxTfs3tKDUTvonSxxB9MLcWzKDPm2VlxXoOaKiFEdGt_NrKEVfVTvcCOaAN
 WBX.XfY9DdpWwJ6m6R0lMIH4TnuYli0XlQ4pH6v1And5tNpXJn5YL7MX5bM53ZERLxAmEh7miMJG
 mH3TeGunai7tJEyWvcTpzqN5T8fv54ZwVgr1tnAyXAxXUvFqlBSyiCbydjEr5uz5xbdhsHCDO9Z_
 ObmI8ctGMu18g5joCqNY.T7tsmV.0WGpLe.RL6kee30rfAwEGFaBnYoHFSqP3jSZ6riq1PSTaGH1
 WfyIXsEr7wTdtcHn0feQwEbWDOiwXDqni03lHmx5duYLVGRE305_4IIq2J4l6ac.uoLay1nr78cO
 2s_eTOrUpOJq6jHwy1L0eX1B1c1mpGLSBsx8mfpk7CdTf9sauRL0p93Oi9hF3ThKy880nTpmh5lG
 43tixa9APQ33f2qjW_Hcg1xp38ptFr.cbnb9Zm28p6ocm_QDJVWz6jqpy6PbvqPtuUHai2Q4wKQ5
 RYXWpTZjtCEA94eRf3S8JL6rIqO83rVR4islIhdQpXQpov2RHjviyANq6TgLqa1C9oiYHqKK13Po
 .1o0_7UXJRG9wVfYWRJE7YvkKmv6nKFdDFu_Y3XtIWAfJQz4R8wd1VR.mxXtor2NIngGfJwy8ZXF
 bHIkhxP4TlyQD7RUpsoE1SH6kdze.fdfdyZ2alCxI3PqHE0o1xD3Osp4_zMqlgKrdZcfqHM8ePwX
 CAI5C_7zjDb9Wo6_9ddKvCBmvoxdteHiw860AeFEmyl1p_tu8FWxa70PSKnbgPRPCwEHtjVAxReZ
 t4O_ChZ24X1pR0xCnM7mzTjOqNkfaDmqGzSvOBMLcPSmaudtXcRGM13_b84fVALuyWJyMeiToap3
 CsNEMsvr09gNUz6Rxm9tx7iuMv3F1VgsgqecJHekAJSLLU_tP50SEKROIUTJBl0cFrugH0TlR0T3
 Ix7Shd79479SQR.4XcOtyRUlhr4gUVgbF3WQY10sq5fbj7GtXgOuxCjiaFDMFWFosKagwUSDc1vl
 3DCe6uv5fdMubX37gk03qCAoAAhnpvV7N3iMRH5XkPu4kV_ZDTWpd7X.0c.SJlsLH1XI2h5PcHoK
 nSfmkh3JkCS2iUnq3d4oq3cJuekyXF.I2KnP5ZssQpnE0Cz6pVOn46r9.ZUMWOgJ33ZAumt3jegM
 bjWtwVHRxDddg7.LHalXmFBuoBs7k6xEuOU_P.4CPcHMez_CeNa9oh9AoUbHaFQnhs1nIG8uRZSE
 JSmObdlrSzPRHI_18s16Lk0byVQ6mzjKyOGISTg5yPVZ.WQuwAHYA5gTo9s6Px.FxhZCRBh0.DoX
 r8cOuj6f2x6dxzFGLrwjdFKVJlurffd4T4dLnGZ7cjNfI8dbEftRHGAfmHsHcqpf.Z30kPAt1QKr
 L4uezrWSr0qI.Bsd2RvVeqbZ9_TlYzddRtOaWsIpaB.Wt4T8N8Hw2S9Wlnv7x4zdoPad.rHs_g3I
 Rxh0YQ0HuiPyFxgXdllUWXG_77Z69F2ErANlIOXpszkm_0Hfh8d6XeTk0M7i77pTny8hNrylI20J
 HvQ6mat1c1hvjOKNmn29ZJmUJ5tB.CH4Rb.mC6oK.9IZyTtcAseBu2IFkMy.zixasdisW.u6WuBs
 xVBQlxamzIvdXW_cL_O4I747c0bfQefVMW557jrJwoeTP3a9UN123s0QubugvAlcSx4MSCKcrr3E
 8cpJs1vk0xahB32xnSSdqUKQ3z24IwuVoPthlRBPXG8ZslwXzrcb4Ai9.HIKWpkLtsjTW.SgcHRl
 GHQWgQLpI0fJRlVqdp0BJAfSaIkktHD2N_TN7p3J4xIediZmsX0eyQuvNvv9enRcNOFtByLw0rNU
 RDqQAwUU1AUcP_jG9VQl4qDrxWT_FLkrA2amiKw8IbJ3iv9Vbs3zP7HZbrXBsob6Fstll4MNEmR6
 cezcyH6uZ62nd01FK50xYVGDyszDhG1jad8oRSc3V.MfgvwHygeglamCJridwKoQaumCPG3xJycI
 yiX7BNdutlI.2Ch7.CAB3y6fSkJpRVWunonl3BQ--
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: fd02e599-5545-46de-945d-9fd8f4fe832a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Sat, 30 May 2026 09:31:05 +0000
Received: by hermes--production-ir2-89844b765-mjl2j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f93cc69d1b60df7ec45058898687704b;
          Sat, 30 May 2026 08:36:15 +0000 (UTC)
Message-ID: <0c20ceb5-1cf7-4f83-9623-b5f5018f44af@yahoo.com>
Date: Sat, 30 May 2026 10:36:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v9 0/8] net: dsa: realtek: rtl8365mb: bridge
 offloading and VLAN support
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
 Abdulkader Alrezej <abdulkader.alrezej@gmail.com>,
 Yury Norov <ynorov@nvidia.com>
References: <20260529-realtek_forward-v9-0-e7c61872d923@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260529-realtek_forward-v9-0-e7c61872d923@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293321-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Queue-Id: 3553B60BDD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/2026 6:29 AM, Luiz Angelo Daros de Luca wrote:
> This series introduces bridge offloading, FDB management, and VLAN support
> for the Realtek rtl8365mb DSA switch driver. The primary goal is to
> enable hardware frame forwarding between bridge ports, reducing CPU
> overhead and providing advanced features like VLAN and FDB isolation.
> 
> Some of these patches are based on original work by Alvin Šipraga,
> subsequently adapted and updated for the current net-next state.
> 
> ---
> I attempted to reach Alvin for review of the final version but was
> unable to establish contact. Any regressions in this version are my
> responsibility.
> 
> Changes in v9:
> * Patch 2 (DSA helpers):
>   - Switch to dsa_switch_for_each_port() in the irq_setup error path.
> * Patch 4 (Table lookup):
>   - Convert kdoc to standard comments.
>   - Fix doc description for L2 write operation return value and
>     data/addr on errors.
>   - Removed misleading comment on RTL8365MB_TABLE_CTRL_PORT_MASK.
> * Patch 5 (VLAN support):
>   - Do PVID first in port_vlan_add() to avoid reverting vlan4k changes
>     if it fails.
>   - Do not use dsa_switch_for_each_port_continue_reverse() after the
>     loop ends (use-after-iterator).
>   - Simplify PVID helpers to receive VID instead of switchdev vlan.
>   - Avoid redundant writes in the PVID error path.
>   - Convert kdoc to standard comments.
> * Patch 6 (Bridge Join/Leave):
>   - Do not use dsa_switch_for_each_port_continue_reverse() after the
>     loop ends (use-after-iterator).
> - Link to v8: https://patch.msgid.link/20260525-realtek_forward-v8-0-5eb80a4675be@gmail.com

Sashiko found no issues in the v9 code: https://sashiko.dev/#/patchset/20260529-realtek_forward-v9-0-e7c61872d923%40gmail.com

