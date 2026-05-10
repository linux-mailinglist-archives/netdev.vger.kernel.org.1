Return-Path: <netdev+bounces-286310-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFKoN7OlAGoqLQEAu9opvQ
	(envelope-from <netdev+bounces-286310-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:35:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4174E504DCE
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BF083009B08
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446DB39F191;
	Sun, 10 May 2026 15:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Ief0CCpq"
X-Original-To: netdev@vger.kernel.org
Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7339FCCD
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427311; cv=none; b=SncLqG6LcUNBOY/ITA7ZWduSDKwLPJdazV2WFJVdWbTdCDTnHuOQuV1o0wxCpUbqh6v09ZyP0J49Q5xSkXaNlXY8akujAAyUxMW7+Hcw6hjjQvPoj4czLZ/2sIXg5jP/Ze1W++QA/ZWKjuxi+Y/4AqYaOEXdlY4WQxHQEX41emE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427311; c=relaxed/simple;
	bh=E0WX8QyW3WFecpS+zkgRHz2p4cWAhBdbu9Oty9/8Hvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWMpdphWBzv595nbcbDaLsC4ak4lxvsg27xlYSF2HZDdZAry1kUqwbagoMeHRlK/KXe5nmRiSQn7k9ySWpy2aMsxv66l6X2QEMNNRno+Uj6sZ4SwgHZ/qMzqMNjgcLLL9Xwbxe3DqPc/YrikJN1AbW5FO0EIA65coG0CCMe8YO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=Ief0CCpq; arc=none smtp.client-ip=66.163.184.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778427307; bh=BgApuCRjqNx62hDmMa4sxFesVRknbQ1cHFpoz/FRJ5g=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=Ief0CCpquHG4/qky2jyA67udBdYSlo9H9rg8Dg8dGq61POX+oIiJQJgzgHw7yQyAcMH6ZJpKzOea4bC731r1Cj+P2V6k2iXpSp1eUzfxEyMpOZp/PQxVGc3F/3kY3EnNTm2Fjz7thbVvZNqPhqjNSZ4zNiKM8BSoX6fslWwyXpX7HOzLgyI0nYF1oUY06YqfRnTwwvDYAFibZaGMBUH2Iopbma10LNQIc2OQ4byQmmrCnRz3VTBotW70dj7+TT43I+/WnqV+stBQOcdxZZzQ7HRouoiMI+LNPkOUm9UhR0mZIl/oQ/ZtZvvFJ8CKGQWOpzK5SSF3Tdvt2QIRpel8SA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778427307; bh=ADH1t9fvQ5RxWC1TBMMvTfPpiTAMk8P4Kk8MOaH3H7G=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SYCRyon4e0xwSehAqPFTiqthoURjJ9lmOOQrq+lFTj/2Lxa8PWkBYX9lE+qmaAnsEKTcJb6/tvEkdLLzkQuJ6M/MbfzL/aE1BKxbH3ffO8Q91JEfjvRK0OJ0iihrxOZoGlDpp1HjpGO2Mkn1nnhVfSHGidIyb86GUC49kqCfJYbXZA+3pK5Hi4Ser6/f6VPTQctqSn/CKs2NkkHkBqUtQXeaY7Hyk+eaZC5myNq0UB1/K430LubztGwYbkP+F1gI9M3mcw9o+mc3JNAQnhNyxML+CXGEWW3fFi3h7VaMiofurv090GOfD5VTIVnYO2A8YA/rvIjLZM6vQkWBjpZVXw==
X-YMail-OSG: 1XUMlg0VM1lwk3VuQvoqmWElPN4sFgyvg8_.KqRfPItcwxH_rf0O0aDsTzBedMZ
 go.9ZxDAmQLSwhGBuH3z4gFhBFPEIM.cl4lChLGkYfFNB.L7Cbu2tAoTjHqlz8YrmigdMT_B5c94
 QNWWavq5x2.fyGeUQPEtmhxXWOX3L.gQQpdVoQbIcn0aYudP0oq9wiZcsOqlg6n9l20daeiS9efK
 tyJDSkquLipxeWMZhiXdpjjWAl8TOyAS5UHZfB6y0KluguO.fRImQZRfoWIsvApaO.sR7.rLB_YG
 gHF6ge1XnzHPsuueUlTNT10XJeLcnGMlizgWcvGhsPCMhN99b18JQKFIMzn7QWzat.Sv1RnatgvM
 J_jiPeKZxppidOnoLgjypCc1j65Bcs5irXEu65mu6j_rIN2PnygS_TCLzFCM0z_BhJpo56FNg6rd
 Z7SRr1RJvKWu0Zx50Vxm2K1DXVzCaRip.ur1r_5gKbC5b3t1SKxPPn_teeT8hzHafeReqoPjMgfH
 G9j_7H_tE_hcJVJA3G0zwnJp9ClAMaLHXo4kFk_yZTIXu2NAzWqdPGjmNyhpUlAfb4FspDU6sU6z
 aIWHXzZwhOW6eOINCfDSvtNTOgjl39Y4kJVaHVvesEiYsAzB0zFqTZX6.cnexuaKe4ehUJV_gqq4
 Wab.KvV1n_lHzQVDQAp9ZLdVHqIfvwBmpYAKx_QmbpQY79TiN3cp4SeAgll4Hr2C7ocfVTbuk7sh
 jQAmPhdIEJCzXok6DzBHNlIJXUxyrrK27eMohKePEuoX4hGp4QSIU8ScMUc4wLNcKU_aiBnlv1.L
 OfdYC7rQ_CngYs4W6FW5H.khwr1UQNyvVZfM1z4YTTnCWQY7UTRfbismNusRhTa9oe4A18RTNw0F
 aw0hhaBxyFOSg60yAHji6jiWvS5oMZfuOHTsAthGF4l6hENernj1j4y2S_C8IZUtwRMBdekoh1UA
 XTh70aZt3AAyQUng.DnA2QyXrybwkmhHl6P4xRndBzoqmUV7BihTLL0SQtK2aDe.PnTiNQb8noQo
 EFVktJAubsItO3tmM.lUM_Pxhzj21f5xFaV2psIEnLDikd1vBi4wm54LsVVEQ59goT7fHoSFTdtk
 A2GM9X6lBfkK5yHsDWZIPAhBsPk06z9NgC9UlIsw6z_6rMSyb7ecjLrr3lmVGhou.icAfv_QrMyJ
 l.AcK.YA3keBAz2Ku3gvP4rFRVR9zLDff5IWns_V16Od8hKga0yRL6BO4bVm662XQuxmnejik6kb
 psqK_.IdCtz5B3nwv08gAuMqS8.hrkvLyyl8NolYO2hQlkvMWxmEWEqXg4D0GdNuzNOb4V99N9mi
 LlVSSzh.HrMqTWJQVOuUujWMiw3KfPHARZU1xfWsulBImZx9YwOoP7gYd_zL.uNxC4rsunUyKM9e
 JSx3kl7JVr5zGLOFGWGhowoB_f4yIsPirkmD3Q4VfOOpNBeFczShtkeGylIh2ejqRJ7zIEv6QNZk
 BjN2H7ySZ0rSWQ1EpUyVRSaT3s.YuEx2p3XwWgwKQsWgGlI7MJqDVNq9BQdPiPFgVyK8sedd.uRx
 EyxXMYaReKNqJ0ONA.DYgzeZrVyM0Q3zsFidTpXunQxGWolNy9eHbXQkixrXeb6FgEyi_9o7Oyzm
 pr8jAkerSpRiZjf7FeADn9arHfVWBXsfuxy.C7NqPzpSDGflKgXeTx_Mjx4LC7cdGuw2GpgnQHUO
 o3o23GgCRMJfyveAliMnsYlBxgbACUpBQgRj8j_7QX96CoJ44.5YRbapmMs_ESvSyjWAHtDNxfu5
 vNMv6KgjWJKwZ90j8nJmHN7avNjzGUe6abcyLNMLwo6z.XIrX6BFHtDs16VaHmLYdmxzg4z6W0dV
 xd.6JgzO3Tf0s1hOHWsFKijcqiHEViCZ7Ku0LMfawniNXOanB0EIRKBOlRNhLoHZxcnGmJlj29xP
 erkK3dxYMKGrIv9Z1vrN2nTqlXyPPskVEBmHPLTwQJ726qqclGwFe.hl7orBYtaMFcNbhBbLbR70
 exV69rmJSxnul7b521I4tt.oes6Gaw7Za_jq65EZvo7gkxlz72NGEm_YSMPArNE9Z0UIPSZ.GKam
 O1Rx62kQAqtcokdtUPI1zNkib.Egqjn5QkZY9t8r1iNXsLyWCkfhFRoGaAPFYI.J2KHDDrExSJ_0
 dvm27u2J85jMXxKGSPWed_Lh22KVQ6idnnrpoJUjJ.kr__f3JcFt3k6M8n8F2hC15BN5iNiu25hd
 RpiOO3ibbv.XF4.pl6Ap_1GPCE1oFjBISz8jxwuPLiHUrTfrBysnddtyYo9ePu.BFanZPlG1c6vF
 TtOhPCeGzrrbXjEBHoX77nG4DpKKk8O6cVsLqFVKaTjiXerJ13Xg-
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 36f58c25-3f1c-46e5-a43d-7da807e96455
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Sun, 10 May 2026 15:35:07 +0000
Received: by hermes--production-ir2-89844b765-6g7zf (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID f3a60c2a7e4c7c2f524555c20c3c538a;
          Sun, 10 May 2026 15:24:49 +0000 (UTC)
Message-ID: <4402ff35-ee1a-4e9a-9160-611c32e4c710@yahoo.com>
Date: Sun, 10 May 2026 17:24:47 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v3 5/8] net: dsa: realtek: rtl8365mb: add VLAN
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yury Norov <ynorov@nvidia.com>,
 Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
References: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com>
 <20260506-realtek_forward-v3-5-1d87c5f85a3b@gmail.com>
Content-Language: pl
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
In-Reply-To: <20260506-realtek_forward-v3-5-1d87c5f85a3b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 4174E504DCE
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
	TAGGED_FROM(0.00)[bounces-286310-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/7/2026 4:58 AM, Luiz Angelo Daros de Luca wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> Realtek RTL8365MB switches (a.k.a. RTL8367C family) use two different
> structures for VLANs:
> 
> - VLAN4K: A full table with 4096 entries defining port membership and
>   tagging.
> - VLANMC: A smaller table with 32 entries used primarily for PVID
>   assignment.
> 
> In this hardware, a port's PVID must point to an index in the VLANMC
> table rather than a VID directly. Since the VLANMC table is limited to
> 32 entries, the driver implements a dynamic allocation scheme to
> maximize resource usage:
> 
> - VLAN4K is treated by the driver as the source of truth for membership.
> - A VLANMC entry is only allocated when a port is configured to use a
>   specific VID as its PVID.
> - VLANMC entries are deleted when no longer needed as a PVID by any port.
> 
> Although VLANMC has a members field, the switch only checks membership
> in the VLAN4K table. However, when a corresponding VLAN entry also exists
> in VLANMC, this driver keeps both membership configurations in sync.
> 
> VLANMC index 0, although a valid entry, is reserved in this driver as a
> neutral PVID value for ports not using a specific PVID.
> 
> In the subsequent RTL8367D switch family, VLANMC table was
> removed and PVID assignment was delegated to a dedicated set of
> registers.
> 
> All ports start isolated, forwarding exclusively to CPU ports, and
> with VLAN transparent, ignoring VLAN membership. Once a member in a
> bridge, the port isolation is expanded to include the bridge members.
> When that bridge enables VLAN filtering, the VLAN transparent feature is
> disabled, letting the switch filter based on VLAN setup.
> 
> The use of FIELD_PREP for reconstructing LO/HI values was suggested by
> Yury Norov.
> 
> Fix for vlan_setup and vlan_filtering was suggested by Abdulkader
> Alrezej.
> 
> Suggested-by: Yury Norov <ynorov@nvidia.com>
> Suggested-by: Abdulkader Alrezej <abdulkader.alrezej@gmail.com>
> Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>

