Return-Path: <netdev+bounces-280941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOT2AyUC62laHQAAu9opvQ
	(envelope-from <netdev+bounces-280941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:39:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3BB459F44
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 07:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A5CDF30142A7
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 05:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D7C3446C4;
	Fri, 24 Apr 2026 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T76OSyCT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3227033F8CA
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 05:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009122; cv=none; b=IFHT2c8Z0loB7bIEbNZ4BUR/ywhT+tC0hHOEAoJcSF5uTesABMKIqzuccvOfjDKzySTqY7m4JKW6kxDune8wKRmGvwoCf3TtgsTgyC9Vo1VwGlBn1tyiXotEo7fhSxw/8t6XvDuPUefV8dMxCLzOVL8OYagT8LKqc+YNdmJx+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009122; c=relaxed/simple;
	bh=ZHcJ9yN10UQ1ZYtTyKaJpPQw8yGQuS+4FX46G62En70=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NqfecxbvXcbdRifMaSFnpP1ubzSBePjifozazWDR3UjYcMtGA0dv/wBKNg/gi/MXvylIbCedzGytmXoWVskq4/2uckLJCMyQINZ84s18FDxKdFQQri4Z2LLyK5k2uimTffVtVgkJ3WosdqauolqZlQ6BLZocHui7myvK1KPO9qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T76OSyCT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c796163fac5so4452409a12.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009120; x=1777613920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oqds8RoH/84yfTSokzcPq2kMkpQyMQYgcBM/zS1eRPE=;
        b=T76OSyCT/NaFFkl1n1qZ4KAOTWQkoyVsWQ6b3vbSaKz45AIGuNyRem+ssC0UE/vi+p
         fjJW4vQ58vVkE9wiRMyAcQw/MMkg03cS4VvE74FTn1qvO65xAjEId2EvJm3aEjkH+2h5
         V2lrqZ8NoxMIAH07lCiGotvQ8lEZXVOJ6cfAQUy8QpWKuCrRac836a67gxQPAD8pBhpZ
         yRQtADUYFNQsT8WbOrdnReUp1E71vnQ2DqxYAdmLLkc7r2MC2Wfn3Sr/jckb0ihwP1bS
         nJsM1kwFK1f0PrAUuGzQV77sWox5oP3MyjF7nSIhtesgg1Nhb/EVAxIrBWdr0rVJ/S/D
         JXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009120; x=1777613920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oqds8RoH/84yfTSokzcPq2kMkpQyMQYgcBM/zS1eRPE=;
        b=AjF3exU5y4mEcOPxsJCD+OUlpljbZViFgyJTkJIYWKDsOyAnRcTJBab3jrjITQvxGx
         IMOSWVYkjmeklnVfbg7yv+TuoIH0oSJK6G6pEUqkKkfYnWeLlRYCLNFudUjFF6Y5jr19
         ozDnhpx4WBNZdW09aWJilWyv/8PuOMAZoxhRbdhERkkBcZcT4eIKRZFMneLPdq9jbQYz
         3sjA2viqxzfeTY+jmXyL4Itmrc2I8lQspyvgT6agEslqG72/LBsIxIULlMadrA5pcYfW
         zT2FYuueNGebEK3p5Z3HyMmAi4a7MeycIb0WSuq253YCSOUaIjX35XvMAvWAgQKk1y+s
         fwMw==
X-Forwarded-Encrypted: i=1; AFNElJ9csJpjfZ/SHJsIsShjrt4qFWZCRMxIMRTaxwv9F4TEA9yHBodB+Vbm45SdehDgm1gby5PwQ+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh0ll6Ld8UttsuV9ze8VrZqvzIZO74q6e6kpSxZq4OMsuqKUWL
	I40eiZhnLPw8+rpsTUQKbzqM/b2q7oXhai5tlMTfp9yLlvBkJJ8ORBQz
X-Gm-Gg: AeBDiesMKMMgzDaQjmW3Vpu3nY7d5AGwTfDEExv+7m4DFdnxs0TSsZBvI0ZowKqg+tu
	YyglXDefK2mThTxrNnIMsCn8vRWB4/dD0x6SaUiVdazU9P38tK3lgf7aadFgCjAmpKLl74SDsmm
	928TIT2E3FiiU8xxd9g5N1cYD7ce5JG8N2q+zRv9Jo8uJ6CAsImc1BaAoyGc+EtEUlFjqeuUdiv
	3xW2JwSldMmoYjtpGFhTJ3NQZvnaTO0rfKgcfITXu4nIPCKZl/FxAZ2fbt/P8g9PAx0zqXZ5tBV
	BjiT3AHwIeVT3LJwzoVRxi7/XPJcfXmVaWoCYMoYR8/nycge2x4vK/wsMMm+Y7rEpSuy0dMRLaf
	Ma3tZ5llhnR6/YHY/DjEEhSSw7r6InhsFJH8YdbWM0WdX0Nk3HhCOMOjAm6HuFM2I1V4QW93wnY
	fOwJ4H5hI6tvEpvxXfLivbSCaBzn55QGSIL/YegiskwY3RlunvyC3clZtI5o03JzP98F3Ke4Fe3
	lELwUmH23BHe2qH+UnSj7mDVzibXA1bRx0vnmyE
X-Received: by 2002:a17:903:17cf:b0:2b0:52b7:e82 with SMTP id d9443c01a7336-2b5f9ed031amr305417545ad.16.1777009120528;
        Thu, 23 Apr 2026 22:38:40 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:39 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 3/8] xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
Date: Fri, 24 Apr 2026 13:38:11 +0800
Message-Id: <20260424053816.27965-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260424053816.27965-1-kerneljasonxing@gmail.com>
References: <20260424053816.27965-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5B3BB459F44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280941-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]

From: Jason Xing <kernelxing@tencent.com>

When xsk_build_skb() processes multi-buffer packets in copy mode, the
first descriptor stores data into the skb linear area without adding
any frags, so nr_frags stays at 0. The caller then sets xs->skb = skb
to accumulate subsequent descriptors.

If a continuation descriptor fails (e.g. alloc_page returns NULL with
-EAGAIN), we jump to free_err where the condition:

  if (skb && !skb_shinfo(skb)->nr_frags)
      kfree_skb(skb);

evaluates to true because nr_frags is still 0 (the first descriptor
used the linear area, not frags). This frees the skb while xs->skb
still points to it, creating a dangling pointer. On the next transmit
attempt or socket close, xs->skb is dereferenced, causing a
use-after-free or double-free.

Fix by using a !xs->skb check to handle first frag situation, ensuring
we only free skbs that were freshly allocated in this call
(xs->skb is NULL) and never free an in-progress multi-buffer skb that
the caller still references.

Closes: https://lore.kernel.org/all/20260415082654.21026-4-kerneljasonxing@gmail.com/
Fixes: 6b9c129c2f93 ("xsk: remove @first_frag from xsk_build_skb()")
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/xdp/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 6521604f8d42..d23d1b14b8b4 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -889,7 +889,7 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
 	return skb;
 
 free_err:
-	if (skb && !skb_shinfo(skb)->nr_frags)
+	if (skb && !xs->skb)
 		kfree_skb(skb);
 
 	if (err == -EOVERFLOW) {
-- 
2.41.3


