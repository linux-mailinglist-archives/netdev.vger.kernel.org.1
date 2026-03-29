Return-Path: <netdev+bounces-272870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3L6bHO/6yGkrtAUAu9opvQ
	(envelope-from <netdev+bounces-272870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:11:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DB5351863
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 393543005307
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB78C2D1914;
	Sun, 29 Mar 2026 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebelreich.de header.i=eitschman@nebelreich.de header.b="lWKNhs4H"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A7285CBA
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774779111; cv=none; b=IScwu3DJnniJZ48opUYmqdcq7juvOiX3UFSYOKv7WIi4uMuICKOzhLySoBp6uQQMBO53ONjO4/S0SWVVbz0xRXpc5RqI79mmO+IQvrz0uCyj/ZBPNRiBq0M4v1VuDHqtbZyztaGDs0wQVqXm7S16d0APZFGa9u36DA2J0ZgxTeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774779111; c=relaxed/simple;
	bh=/Q3x77xvg3ZB3+VFb3GxTH89ZpVyA+23z9zU9pt+hzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TODARXoHxGFF+lzYvoHPD3DXkrXNCeHgxDDHuzRa3UJ2LSZSUW1OQOanr4XSpZHafTJ9dV8knRE96y9qjjhCMIu5lvSECreOh2+uoztZxgAXYWa3Mvg/VKTjrM07imbj0dwXQmGV5Zs7spT1kQr76S0WQc7DpyeodqDYHfsNiAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nebelreich.de; spf=pass smtp.mailfrom=nebelreich.de; dkim=pass (2048-bit key) header.d=nebelreich.de header.i=eitschman@nebelreich.de header.b=lWKNhs4H; arc=none smtp.client-ip=212.227.126.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nebelreich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebelreich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebelreich.de;
	s=s1-ionos; t=1774779108; x=1775383908; i=eitschman@nebelreich.de;
	bh=jt2uIeRPuBlDYj3MvR7QxlrUUASUFPPj19tl4ayc20Q=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=lWKNhs4Hx65B6bWHRvRQYau0ZJN3hAA8Fl8of33fZgsByMVBGmsQM0iOlKxaZa//
	 RaJFWLIG2WgaiUI+VhGEbvv28zckuaMtkjtCwkwqltkypHxjsM8HFynWbH+QEgJX1
	 /2f3s8g9pqAB6CXOyNbIHNfAk2eFt+ojgGrOFCeZNQRt74tgOdbEooMc2hdHjdiUl
	 jvd9NI2Ht8+kVJiCQzKsrwArAfRahrT7ziqI5wNl7mxD6eqyOcpX2z0op8+fKbRfg
	 dNfPrDB8rPHNw9JHtx0k46/5C/4jqXwyXWwHATQnJFkaMGfsJx+Hrv8FmuRMR7QiZ
	 sGY49t/iJvtMnU4QNQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue012
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MlsWZ-1vh2ou2SY7-00kpub; Sun, 29
 Mar 2026 12:11:48 +0200
From: "Andreas Haarmann-Thiemann" <eitschman@nebelreich.de>
To: <linusw@kernel.org>
Cc: <ulli.kroll@googlemail.com>,
	<netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [BUG] net: ethernet: cortina: gemini: skb leak in gmac_rx() causes kernel lockup under sustained RX load
Date: Sun, 29 Mar 2026 12:11:11 +0200
Message-ID: <000001dcbf64$725ec300$571c4900$@nebelreich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Ady/ZEVLqiX7zl0vRlmrxMWD5MwYIg==
Content-Language: de
X-Provags-ID: V03:K1:B9FfPFYeT5xhJ5DXzXuBy/iUUe772T1XyNmMt/CLvGBuv47Udr7
 QjGwq5SWhrzJJZbie/Ti135I5bse+kaekARFnGX8qbcMXnSyIZdYQ7zLn2BPHaT8/VMrGe0
 oXNkrrd8J0nJI6KAocMkcpdV4rcgKeghT8ekK/Zj25cer2zYaIv5NvqBVrjYaiKkt+Cipej
 aPQ2c+INT9JNdXQjjQUAw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TQONWpgu8ys=;UorpyPnCJUFiuYLCBpsWVTO2JwC
 CJ5XxXEF8jF7D5TAH17SdTdZKwND61nFYLeVTVXg4cb3/12Lk9vytP/wW7tid4NiRapWd2e7s
 4EM+y/vytYdRfHO6sNWdX5jcn2jqGEAUTAyFgsqIiwC/2hmgSrM0ALSO/p0o4dijiBCoI0MR6
 QzNlbw5ROkGuYV4kjemceq4cjSeG0mwi95BGlCnHMVeN2SEHMYcGnGrG3xjmNGXCuZKtjC5sj
 NkvF9/yEO2kZJYFKRkjKdb5ob4XFyOfrb/bToa6w7D78/b3A01pizLlY+XhfP7uc6TLin7VrI
 JdWQZ8OVNLP/yCuyMHso6oldtmKAaN/c1/4KdAo2mgASafGAyiwdWoFnnEIKh/dysE6DaZmyH
 on3FgAxrlEIvV1H1k22ftZvTqVhM3tC0Hi0I4K4aw+JtWc1nu8+ZJLfbDOJMYwFq3osKdFx/3
 bJbvH0U/F7B0cw1BNhgUGLU7MEr8J4cgXoyvGV0b40H/c1yWpts8oJUq/wRxwELgnooqli1kb
 HxSZi3volQI2SGZw50fkF5ejmZtgTdEorld79Jsuo1MBdPYksyTmkR129XZm5DUiodBV5mx9r
 9czi8LlVDMMsZAFMUQNNLbXht7n+ilN+0zQlpXeZnMgqEI3lmmxAXNSwxJlX7OIvZYOB0tWfb
 oaDiHm0qKSUUnjv5C6rPKnmPX1r9gFfN/5YO0qVrfpC7e2TI551eIPlL+sUghizq67JWNq96a
 fsBxcKftkaobE3CSnMiDYzHRAah7GnaqjdGPlTs3abnEngvdS3/LI57vyfEt0Ic5wowHJ6h8R
 eAApW9M37+lA6ipUo2cpZljcqPsk1vlxqriLd5Vuk/XtgErF4yIHnq8O6cxSy4PwieC/oP9Wz
 br7/1wJwqaPju6O0nfrvJad84MqLhq+2aJZGlBkeGOI+BIyH4q5ABCA97igFuprai4p8MCUQd
 HNXwashxgIEWIMdb57s400VpMqiQii2Ow2JTQtrmz41XLcMUcRywJbWsHfZfL7T12qbed2syH
 xzIbZXvSJntVUNcgCpaD4tMA0K0MpfNXKv1t3s0xabFYN3T+N66iHtWZD5S1nEQncvC9vkKdF
 VR4PT0o8gaGkJhZEME2pK+631Zirq1wX0HpbWDPVZ8VCE1a4hQlCbEM5S8/4KK1gB9KmJ0CoS
 23ZvGamGUMgrkSD8hSuMXK7xQ6IeUc1nMt+6rNOeljr8Vhb+2DIOBEoBeWWj6ISnEzZrEO+q1
 GKtNJoSjjjPKi8eBSjkEvpNjqSlY9QhVNStft67osBbwt8i8yzpGrDOyJaJGc0SXwUh+aslq+
 Y6fQ3DTnzo1e1YtQX1/H9PJKDn8s6IUr3uA+iSiDoDDZk8Ub1fL1+ljGCKZISYDM6iRulSrNJ
 5eOxfsCtOEmzLiTPNT27190nupzgKu9Rq208+CwyBO1HPNIAuNIHRKTAJz1V9CiP8VIChrUWl
 wYyn5SYE0p5AVXpHzCeNkasV45XZV2TRwe5jsNt15x1jZOGjkslPhU3CiX2AEX0uWEldsrAl8
 ExJJ+qcNPhDqmjAu+faa1RsJLArryeDBspqZQcI43uRfXHH6CRtLtOwsOVVygJfw6L2YJrgV9
 wcs/Y/uRWThVzWneypTruJaFhbOPW7wy3P7N9J+pIXSXqnmF7Ye36Ese0neexW66wyoZoHIjw
 FwGhK1t7kX3gbdyfAnDjZdasp6zvKWRks5v+SZzrM7IbuoRcm3pghH7XWX4uRcIAaeScpSDXI
 nkeVpRFsAxMo2gygbYwvnI/d7d9Mcf/iRbJaQsUEEixAiR3eGjV8Slj1+F69AR7IVWK3EeZaX
 t74Yq8lKbGi7Q5t+ca1Ou1iXocNdp7wpc5SBm88agXNCB+ZSCiQQu7tnWHe1Npv7KF+5QTSnV
 0uCAVAM3FmiziTI7g==
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nebelreich.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[nebelreich.de:s=s1-ionos];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[googlemail.com,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272870-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[nebelreich.de:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eitschman@nebelreich.de,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52DB5351863
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

I am writing to report an SKB memory leak in the Cortina Gemini Ethernet
driver (drivers/net/ethernet/cortina/gemini.c) that causes the device to
lock up under sustained receive load.

Hardware affected: Raidsonic IB-NAS4220-B (Storlink/Cortina Gemini SL3516,
ARM FA526), running OpenWrt 6.12.67.

--- Observed Behaviour ---

Under sustained RX load (e.g. large file transfers over the network), the
device freezes completely and requires a hard power cycle. No kernel panic
or oops is produced; the system simply stops responding.

--- Root Cause Analysis ---

In gmac_rx() (drivers/net/ethernet/cortina/gemini.c), when
gmac_get_queue_page() returns NULL for the second page of a multi-page
fragment, the driver logs an error and continues - but does not free the
in-progress skb that was already being assembled via napi_build_skb() /
napi_get_frags():

    gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
    if (!gpage) {
        dev_err(geth->dev, "could not find mapping\n");
        /* BUG: skb leaked here */
        port->stats.rx_dropped++;
        continue;
    }

This path is distinct from the similar block in gmac_cleanup_rxq(), which
correctly only logs "could not find page" without an skb in flight.

Each occurrence of this error path leaks one skb. Under sustained traffic
the leak exhausts kernel memory, causing the observed lockup.

Note: this analysis is based on code review only. The fix below has not
yet been verified on hardware due to the driver being compiled into the
kernel (CONFIG_GEMINI_ETHERNET=y) on the affected device, which prevents
loading a patched module at runtime.

--- Proposed Fix ---

Free the in-progress skb via napi_free_frags() before continuing, matching
the pattern already used elsewhere in the driver:

diff --git a/drivers/net/ethernet/cortina/gemini.c
b/drivers/net/ethernet/cortina/gemini.c
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1491,6 +1491,10 @@ static int gmac_rx(struct napi_struct *napi, int
budget)
 		gpage = gmac_get_queue_page(geth, port, mapping +
PAGE_SIZE);
 		if (!gpage) {
 			dev_err(geth->dev, "could not find mapping\n");
+			if (skb) {
+				napi_free_frags(&port->napi);
+				skb = NULL;
+			}
 			port->stats.rx_dropped++;
 			continue;
 		}

--- Additional Notes ---

A similar "could not find page" error path exists in gmac_cleanup_rxq().
That path does not have an skb in flight at that point and does not require
the same fix.

I would be happy to submit this as a formal patch if the analysis looks
correct to you.

Thank you for your time.

Best regards,
Andreas Haarmann-Thiemann
eitschman@nebelreich.de


