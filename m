Return-Path: <netdev+bounces-293699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EAgDy5vHWrlagkAu9opvQ
	(envelope-from <netdev+bounces-293699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:38:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A198561E6AD
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 13:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3994302B0B3
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 11:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA52346782;
	Mon,  1 Jun 2026 11:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAAbRrFR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0043132B122
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780313520; cv=pass; b=du3tBfvg/KPZOAcxv/g0mjWEf2RlgR7WiHjH2qUy0Y6IVUHW3k0cNjkEtWfhdUy3MI6A3Dz2xBNGbsiBLd803kmn0PiAJ5t6+CVf0CESOrvNKQ9S9Lzf4YhoRMWk4JAZ7MeBfD2jLLw/o9fPUypKikqfoaLOOKVsnfcHI/WNML8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780313520; c=relaxed/simple;
	bh=yszJgkZCWn8L+J9sz17zUOD/xufK8NMtC/jiWVOFC5Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nbZ9tPrb731hFrmViSK4F/j2Lb/Upsjku77lvS+FD5O6jPYJmL0zcQ4O9XCnIOUYUyTZdsqGQxNE+ZP0S6P0+6esPDuIJIfTEokD6KHREsv1olr02zTK1TsKaXMglMEN963jDxNfwhdAVtDqewZtUofPpTD1vax0RNyv2ycLOcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAAbRrFR; arc=pass smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-13621cca8f5so7281336c88.0
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 04:31:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780313518; cv=none;
        d=google.com; s=arc-20240605;
        b=E6n2No7ZcjqQCfJSm1qKpUANgwb7pJouNXjilrt7rKuNAclhuwZqKsvSnblzaWtUdg
         cIcEVjc7jAgT6qN4JhnVJF0lCFqw5Q+iS5kbSHM/k7FYlHGFx8jlDxKi91q9EbaCSz8D
         F+Ey/evezPvTyZQNq//WaX7+BrGjRYn0k/XY+55PL5xCjcrl1hIEmVt/D2dD1H0OJCAE
         COC8RJ/QJFrd/WSwWiCO/N+UCBQIWY+ZyU9az0wlGZy30DTFj+G5hToB7/6FnEPfkC4Y
         lOD579v5ke53qlxyLLfJ1wWaWKJVZXnqcYUTf5tMHEIby28OXydBuXWUF1QcaaSx6Wtn
         j1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Cqxcp75xtoM57dtYJ+S/ObM2E9rTcqiq8xwIiEu9bBY=;
        fh=ux221i5Vegz0V5+K8IJ1rqrjTk/dwvh10PidRKp0n+o=;
        b=cKADPJMz7Q7E3Vu8bgH1RtsCxMXvkBA9q6BedbSQD+zIOY4MxCQefrzTEw+Z7G1xp/
         0gsR4cs6tMI3hlWY+4OrY7MgxxVfektxNvXhtbwgt2AJezjRwnUGv1MfvEOANUpW7QHF
         crPjpk80qJww6MSX+nLIx9czlRo2HqTKhQZGx65KNmRNX4QIfIr5XL818vJ7UulYxY4P
         3Jhfw41Q+EU18wzrj2JOwyaeRmNm1gi0YuZfdUqP4kWSS5oM25rEMcK1LTJnrjvLcKcR
         djr5ywCUXPdv3eDjN4JNd4BOdbgUtzaVQIV+tsMbzpr1bhAasmHDWLHTXunXPz+qnptg
         ttSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780313518; x=1780918318; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cqxcp75xtoM57dtYJ+S/ObM2E9rTcqiq8xwIiEu9bBY=;
        b=KAAbRrFRLEY4qF/4mjQ3f1UiUQtiSbfzHtE6YkKMtz4kbv7WMHYZZduU1irdoFu1RG
         X3H1QVzRlbdcKapY+Mc8CYbiWJ0g+Fb5ht0xpiKaLbf974vZzSHiqR95/SBYCYZXWeGS
         2apeNvaWbm590C8K8R/UWruGoQAOmWHXuUhI0ZikmsjCvOoF/bjEgk2Nucn8f+8G0YMm
         5zl0ZYPqH1Jgmlfc/fAqpSjGTK8cyswDZrjoPJ/yZTrIuU4V+6WpqFELU4eLPrDi3sjP
         Qu00teTpdaKxu5Y5EXqbd0k/wxeZA0Ma7KZ1Oga2j6RFRxHyeFgKIxgPDtyAaYnz/fw8
         i9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780313518; x=1780918318;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cqxcp75xtoM57dtYJ+S/ObM2E9rTcqiq8xwIiEu9bBY=;
        b=tZR2uxRvgFhqolC+AWiL3kgyObR4BApe0gQ2MQ3vaMYq1P74wWu/kGChYv3FTrMhcl
         IWAxhdIx02x4q+asG6notXXqKdPLgk/Mx4+2UxUDDCuz7XfVFkFLEwyz0ZrKIxMcKR2d
         urkJaE2SJ94NpaDcfpVS98TQGqUBThP7sOLEFn2OnaaIxtJ0DzG9wu5SJ44tRTMG5kQ0
         fgCWxza2G/iJzKH8kYdyjZPwuBgCgVo/7TzzA5tYU4TYSxHo4PAtt8/ZeYZGOQIeSMF0
         OESgEXgDZW8qjM1Pu8P3IdBIN/MsohC6yHFdbCaLp1v5ewATji2Aen39S+VKHKAJ9KiX
         1Kng==
X-Forwarded-Encrypted: i=1; AFNElJ92PGeFFvZ8Glo/Nwn86nQP0Tej6Tcf4Cqar8EnPamkRdy2x4AYQ0DhZAHFVJZY9/wKs46W038=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDoxjs+Wlq9O6Mtog1dw/rtgsUFwskI9WvJ0oQT1z9pSH2Svx6
	8I0MIpduTORwV43NJ2myKHbnnHTNiyFxPGVxIAXZtNBHDYoOTJZOW7IcVlSGRQVK27uViLA5VcQ
	G7c42U8jZaj3+G6Ykyfxn9pYsuiADCXo=
X-Gm-Gg: Acq92OEH9IBgocCQYJ+dgEcaiNM8o9qGirlt5qcux4/iycAvR3QlUhZTFY3XdMa35Lm
	GLeGWBNK+HugfQr6heu7PMDg7QBpC/lnPbL+K6rkNIsCaPKJbdTQz9TQrg7NsdjAc8u/7AJ9mtN
	mxn+Vhyfa54ltMNofN9cxcIwiqDgb8nqxn1oWSPCfw8ibghh7kEQ7b3NY1qvi0bM//xwoNXiO+z
	pbjb0m0VvjI5EjsOfmJMBznk5ml6Mpuoxn6SG9G667fRIUddUdcrvxo4aWpVgDRMmNxSKnqA0L9
	7BqUu33/mM1FQ8AE3l8bwIq1x3Vy
X-Received: by 2002:a05:7022:392:b0:137:938a:1044 with SMTP id
 a92af1059eb24-137d425e735mr4514505c88.33.1780313518020; Mon, 01 Jun 2026
 04:31:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: boz baba <bababoz943@gmail.com>
Date: Mon, 1 Jun 2026 14:31:48 +0300
X-Gm-Features: AVHnY4IkZaXRztFMyZ0UAa_2Q1e-88z0noe4I9gVIsgWROR6bbGX68MZKK77zWg
Message-ID: <CAAB7JC+TiyF6-1uvzhOcJ9KeDUhNgLmXk8unHNogY156xSu61g@mail.gmail.com>
Subject: [PATCH] net: esp4/esp6: missing skb_has_shared_frag() check in 6.1.y
 (CVE-2026-43284 backport)
To: stable@vger.kernel.org, steffen.klassert@secunet.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293699-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bababoz943@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A198561E6AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi stable team,

The fix for CVE-2026-43284 ("Dirty Frag", commit f4c50a4034e6) added a
skb_has_shared_frag() check to the skip_cow path in esp_input() in both
net/ipv4/esp4.c and net/ipv6/esp6.c. This fix was backported to 6.12.y
but appears to be missing from the 6.1.y stable branch.

Affected: linux-6.1.133 (latest 6.1.y as of 2026-05-31)
Fixed in: linux-6.12.91, mainline (f4c50a4034e6)

Vulnerable pattern in net/ipv4/esp4.c (line 912) and net/ipv6/esp6.c (line 960):

  if (!skb_cloned(skb)) {
      if (!skb_is_nonlinear(skb)) {
          nfrags = 1;
          goto skip_cow;
      } else if (!skb_has_frag_list(skb)) {   /* <-- missing &&
!skb_has_shared_frag(skb) */
          nfrags = skb_shinfo(skb)->nr_frags;
          nfrags++;
          goto skip_cow;
      }
  }

The missing check allows an skb with SKBFL_SHARED_FRAG set (e.g. from
vmsplice()/sendfile()) to bypass skb_cow_data() and proceed to in-place
aead decryption via:

  aead_request_set_crypt(req, sg, sg, elen + ivlen, iv);
  crypto_aead_decrypt(req);

This is the same page-cache corruption primitive as CVE-2026-43284.

Please backport commit f4c50a4034e6 to linux-6.1.y.

Affected versions: linux-6.1.x (all versions, fix not present)
Fixed versions: linux-6.12.91+, mainline

Verified by: source comparison of net/ipv4/esp4.c and net/ipv6/esp6.c
between linux-6.1.133 and linux-6.12.91.

References:
- CVE-2026-43284 (Dirty Frag)
- Fix commit: f4c50a4034e6

Thanks,
boz

