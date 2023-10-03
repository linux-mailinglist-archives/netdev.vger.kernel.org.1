Return-Path: <netdev+bounces-37780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5D87B7237
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 22:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 232702814BD
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 20:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CA43D3B8;
	Tue,  3 Oct 2023 20:05:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10D13CD1D
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 20:05:32 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91322AB
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:05:31 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f67676065so18839367b3.0
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696363530; x=1696968330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hh+n8bfd+fHj2PxoCINgvh14gMdSrVtFDRZkzUjMD80=;
        b=pwEt10xmWG+Somx13bpDkvgNdhL+iN037vDTbQZj/ILJ8DDQRTeSzXME8ePmxQms0j
         uJSaLYk3eGvWrZKmc9VCnAMmrQ+lA2auMLxqajqCRVPem76EjKyPNYO3Y7CC2tB7dTS4
         oukZNKBwBxZ3SxaDMR2gOyuRkRUX5qP8spCJ/UQxG7gP2r2wOw7DocUN/8NCmrkk+huB
         JR735qmSvAAaZ0pOtSRVtmZyhcr3eLeuccnh/XnLzX3b+7ZrotBwK+0m1SdH60I3GsUK
         tM5MC5tjyTpWd5xoYrCt2pc79kSe6e3tzPSNVOLX0slAy+TdPo0oQVuBgwvd/oC/B5RR
         hSew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696363530; x=1696968330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hh+n8bfd+fHj2PxoCINgvh14gMdSrVtFDRZkzUjMD80=;
        b=SNiFnSwteAZpYyW8/KPoz/EgVpKUqULU9gxCWoU7L4UCyae+VPpSRyeqAbgm3TfF5Y
         HmRbyt8dJ6MoG05n2b11FnaOPAUYPIB+PSE4JeIXN6s/3amraH7UrTFVJgbaMDXH348o
         0UT60HMGHFO5A3+c8BEs7C8oDT4RijU403Ra0EIZDHwfHn6swf89fWvAgPUSrGg5ZfSh
         zW8vYdzDQlr2IfrSkZC7eZ/FN4O4nCTOfqkdlh2UvdNnl4Sq/rL6/teB/NOtnbY/2Lje
         q0it5EygBx2z/r1b63D/rGeC5zm46IxiU6sfv2M/qrBvTxpdYWy/5JtWO6lTmgC8BsYw
         yx8A==
X-Gm-Message-State: AOJu0YznIGNzMOc6Ix56d3tC2BMhRHJMK9TOrcb7sLnFF/8gqeDl0Eg/
	LDzIVgf2HXIIgj1BILImFjcRcYw=
X-Google-Smtp-Source: AGHT+IHTQgMe8sMfvHu6NgAk1AoxlPxP/xK+lhLViG2zt8Eyi6GlaOmftpMsUU9ommqz85SWCvaco5k=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ca4d:0:b0:59b:e81f:62ab with SMTP id
 y13-20020a81ca4d000000b0059be81f62abmr12027ywk.7.1696363530546; Tue, 03 Oct
 2023 13:05:30 -0700 (PDT)
Date: Tue,  3 Oct 2023 13:05:15 -0700
In-Reply-To: <20231003200522.1914523-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231003200522.1914523-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003200522.1914523-4-sdf@google.com>
Subject: [PATCH bpf-next v3 03/10] tools: ynl: print xsk-features from the sample
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Regenerate the userspace specs and print xsk-features bitmask.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/net/ynl/samples/netdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/samples/netdev.c
index b828225daad0..da7c2848f773 100644
--- a/tools/net/ynl/samples/netdev.c
+++ b/tools/net/ynl/samples/netdev.c
@@ -44,6 +44,12 @@ static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
 			printf(" %s", netdev_xdp_rx_metadata_str(1 << i));
 	}
 
+	printf(" xsk-features (%llx):", d->xsk_features);
+	for (int i = 0; d->xsk_features > 1U << i; i++) {
+		if (d->xsk_features & (1U << i))
+			printf(" %s", netdev_xsk_flags_str(1 << i));
+	}
+
 	printf(" xdp-zc-max-segs=%u", d->xdp_zc_max_segs);
 
 	name = netdev_op_str(op);
-- 
2.42.0.582.g8ccd20d70d-goog


