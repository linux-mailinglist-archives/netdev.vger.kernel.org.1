Return-Path: <netdev+bounces-297527-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F1QuHoIfKWonRAMAu9opvQ
	(envelope-from <netdev+bounces-297527-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:25:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17964667209
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:25:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=web.de header.s=s29768273 header.b=adjP6mZq;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297527-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297527-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=web.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58E4E303C3AC
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E96C3A5E8E;
	Wed, 10 Jun 2026 08:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AEE39A06A;
	Wed, 10 Jun 2026 08:20:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079621; cv=none; b=MED+qiSlD8MTZkjJ7xdpUxxIVWMTGsKCChaX9U6R/1i+BIWJD0ZkZ7ie470fJ2IWR/zADZfutI388cRST3I1knZ8OKJ8xiIya6Ibk3q4n/uVktKprI1HlTU2sIkw0wcWEtfhf759yyK78rIb0nxinPOlwq/pnN7VX9c+iWy9iTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079621; c=relaxed/simple;
	bh=6+Su6fY3gVNk9tajvvQ5ZnhDi7uIVJmxh2Tuw3CcFoE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=q46aGKzCqtMbEsw5w6hQYirJ9mkJJnPdTr/U7Btn/Z+/twMa7o2qhyeJ59emK3t5YQQeExEljqcAV9hZye4+ezx/tKcBeIl485qhNJ9nlhRWEQlggX2ktimtP3yyIJITR8RP2475km4GrYGF0DFOpQAeDA788RpJBlocpHgssow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=adjP6mZq; arc=none smtp.client-ip=212.227.15.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1781079611; x=1781684411; i=markus.elfring@web.de;
	bh=ZecaPoWhKZ7SG+Fblu1EYox89+E6+mi5hzvNFNqSVlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=adjP6mZqzxTzpZVKFBCWZx63fjEbAhEqYhkCLpqE+BlsqreqTOEMNhcU1nSBUehj
	 gyUqYiXGJoIkKROdx1u5n8PLwvDqgO3X+HX8qyM96+b042vkvBEC2tpncO7jtna2n
	 hrGN8Chl9//PIJaaKrG/UsjabL1jWVYRCUNvN3UNfCjqltYDulxuls324xfoO1rLj
	 fFkZLxhhtj/4kImBcNcHXgA7tI3qGYhWK0D9enecfGe/hTJ7p2zrhgAln192Zcwon
	 vkZFIyXpV0XCLzNHqQkkHbGYlCN6opvzqadZPYWE9z6SUdGLhPXkF9BhBlpdP0IBZ
	 KlY+mNVOMkq5vOaPEQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDdy7-1wPpdc0mgx-00Gy7m; Wed, 10
 Jun 2026 10:20:11 +0200
Message-ID: <f0b4e354-9ed7-43f5-8ffe-97019e421c02@web.de>
Date: Wed, 10 Jun 2026 10:20:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH net-next] i40e: Use common error handling code in
 i40e_register_auxiliary_dev()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tt9ftAsMhV2Xd5ExyAJN/6mxy3Lt8yKWDmD1QMqMky0DtigoRPw
 6Hi+W+WTbQ2VT+Cj+zvDkqYWAEsyxCf+pxXrjijeQnv13roYXBBBlCicCP3KW+OE/uA7LZq
 LO//PTXNS+TkXL+/GuWhjEMT/+Klqkc1KPyhFn4KDoVnHDbsFGlk478AtGH9pGNNeq9tMud
 7YpkVq1+r9yhMpxkZ/ypQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dwusOkWI3Rs=;QxSCW9bZ9gk2f5pm6Sjnn+XhAnT
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[web.de,quarantine];
	R_DKIM_ALLOW(-0.20)[web.de:s=s29768273];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297527-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Markus.Elfring@web.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[web.de];
	FORGED_RECIPIENTS(0.00)[m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:przemyslaw.kitszel@intel.com,m:shiraz.saleem@intel.com,m:anthony.l.nguyen@intel.com,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Markus.Elfring@web.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[web.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 17964667209

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 10 Jun 2026 10:02:58 +0200

Use an additional label so that a bit of exception handling can be better
reused at the end of an if branch.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/net/ethernet/intel/i40e/i40e_client.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_client.c b/drivers/net/e=
thernet/intel/i40e/i40e_client.c
index 84a97ca8a6d8..389b8b83afbd 100644
=2D-- a/drivers/net/ethernet/intel/i40e/i40e_client.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_client.c
@@ -304,15 +304,15 @@ static int i40e_register_auxiliary_dev(struct i40e_i=
nfo *ldev, const char *name)
 	ldev->aux_dev =3D aux_dev;
=20
 	ret =3D ida_alloc(&i40e_client_ida, GFP_KERNEL);
-	if (ret < 0) {
-		kfree(i40e_aux_dev);
-		return ret;
-	}
+	if (ret < 0)
+		goto free_aux_dev;
+
 	aux_dev->id =3D ret;
=20
 	ret =3D auxiliary_device_init(aux_dev);
 	if (ret < 0) {
 		ida_free(&i40e_client_ida, aux_dev->id);
+free_aux_dev:
 		kfree(i40e_aux_dev);
 		return ret;
 	}
=2D-=20
2.54.0


