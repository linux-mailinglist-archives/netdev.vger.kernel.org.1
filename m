Return-Path: <netdev+bounces-26874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DC87793D0
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 18:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ED0628035D
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 16:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D21B3D383;
	Fri, 11 Aug 2023 15:58:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708AD329BA
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 15:58:51 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D4C30DB
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:50 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so18671445e9.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769529; x=1692374329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0e3CJJrqZ7ewmH2P5w0S/0zIFsn4QxREbiOM6aZrWvM=;
        b=lX+Ys8CLIATfx0LJtFzeLQ0ERTTrxPkesrFPMmBBNHN86jFrD5P1lfm+ZuIU+kAt7e
         BKBApd8RB4H0cU1jcFTrQziVbtFXdP1duoGwh18rf/io955LcWi7us/52WSQe7pFxdrN
         EJwVzpvtfkWkZnUNNLZTu/xoWO5mMB33a6uemnlGsaUvGomWxdXoxtP0zmFEhhokvjCV
         j/sqlOHXHII4646BvzRoTJ5hcYJbNMEgjwc+ULaarg5W/hYVGjbZHwIv/en9my3r/+zp
         yt5LVvVLIh5SJ7x/IeBaD3TVW7tdwEaGCfOtSkZAIktPoya9afYeSPdirqU9498B2Sl3
         IoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769529; x=1692374329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0e3CJJrqZ7ewmH2P5w0S/0zIFsn4QxREbiOM6aZrWvM=;
        b=NrScw/NJYfYyrRWeqr10n5w0XZFq/U9a1HXswnaQ9gSJVPCXmlZJicsLUW/CSfOkRY
         um5FfmPcWh8UcYq54dFJsylGEsh1rK5ZOpD7okLHjlehY+ZP0seuPDYDMOcRtq2Lh9aX
         dOLgy5uXzI8io2wL+oUKHwg3noJi6WjqDu7OKypJiF1rOROYG36ZiitaB3CWLdbWUwMo
         n6CP6qgiNaHTWDwm3ScmZS3EtJN2BlqPlce7BKiVuXSiWODIUPq0Jcug5UBBWwxnkqVe
         WBGcbPcgPi72+KTiuwk5X8HncE1k59qaKfN5vcsQNS6ZPfL/Ot0F5UXVWEjD8tv8Pdxg
         xsTQ==
X-Gm-Message-State: AOJu0YxfRL/rgpHl26NiXpXzKPWWStIT/S4eDBBDPTgYqgFTUNrHPCkB
	YIbDRk6Q3uVS8Xp+TR3xaxqMcA==
X-Google-Smtp-Source: AGHT+IEMRuVR4UsvMsf8IVtrN3B7SqSXCFwDWFlUx5pvxeBUjQjokyhxcx8/ORvwhtNlUaLQ2ZSj+w==
X-Received: by 2002:a5d:438a:0:b0:30f:c5b1:23ef with SMTP id i10-20020a5d438a000000b0030fc5b123efmr1642236wrq.41.1691769528840;
        Fri, 11 Aug 2023 08:58:48 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:48 -0700 (PDT)
From: Matthieu Baerts <matthieu.baerts@tessares.net>
Date: Fri, 11 Aug 2023 17:57:21 +0200
Subject: [PATCH net-next 08/14] mptcp: avoid additional indirection in
 mptcp_poll()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-8-36183269ade8@tessares.net>
References: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
In-Reply-To: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=J9VNeffJDPfkoJa+eIaJ2TO+2VxqSncVcduqI3h44xQ=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lqvfhQYxdq5nUH4ZAoej7J8+p2L5Lmk3Y0Jp
 4uaCRiefWOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZarwAKCRD2t4JPQmmg
 c8j2D/4z5s9NgjC9q7QH5Jp/JvDdZkfDO89mpDeftND2ALbI0xuUPpP/N2wmHEm9wtubG3ZWDPP
 1YHwLOswxY4RhycdjJc8NMo3j/IqTpCtz/hTNXmOdReLcv1BiuIERObu7456c46NuhYZbG2fepu
 j1sOGlUnf6LxHPb4MLyWv5PtU90T+gL+MQFyQr4j+uumiM719nFQm+yB7j7ULl08oD/x1ZjRdy1
 BD8Sci4RpOCJJYZ5JK3/Ms6H1NOPsULBbPGoaVJks9OsFpEMwky9aPPlpDsQOQAfKVlkLp1mMZz
 UH4zdwDsJIhMC1USzsgCLBM7TZIu3lckmH6QikfyD1nJ/6R7G4jE2u3zJC6uqLWx8EJo74mfqUu
 hakjOElfGBTXTXCBLIDoBFJTDBEFspHXFtzxztgMGB7mDZIUJ2RcUwn4K8r1t7zBK2GhLfxQrNL
 mUHr3pJ/m/h4UuJvc9cyK4DHp6gN7PF/bRO+Kg0ZCTEp2zdoi8UEi24lqRRVZfJhVd2QR+1ueuK
 JZhzQl2UjPNt+UW6kN0DcNIgcIaBi+1T4l1O1zyx8jGXfyHkfC1GQ0DZe8C42hOD9d5//IZqhV+
 T9uAVSAVqZXlJ1unylAdRkJ1lgXkkuRnOri0iROXZx/wK//VK6iWZodcb2jhuj2NaYq/xZr2oAq
 Q0T1caiGXyTPi4g==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Paolo Abeni <pabeni@redhat.com>

We are going to remove the first subflow socket soon, so avoid
the additional indirection at poll() time. Instead access
directly the first subflow sock.

No functional changes intended.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index d8b75fbc4f24..e89d1bf44f77 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3844,12 +3844,12 @@ static __poll_t mptcp_poll(struct file *file, struct socket *sock,
 	state = inet_sk_state_load(sk);
 	pr_debug("msk=%p state=%d flags=%lx", msk, state, msk->flags);
 	if (state == TCP_LISTEN) {
-		struct socket *ssock = READ_ONCE(msk->subflow);
+		struct sock *ssk = READ_ONCE(msk->first);
 
-		if (WARN_ON_ONCE(!ssock || !ssock->sk))
+		if (WARN_ON_ONCE(!ssk))
 			return 0;
 
-		return inet_csk_listen_poll(ssock->sk);
+		return inet_csk_listen_poll(ssk);
 	}
 
 	shutdown = READ_ONCE(sk->sk_shutdown);

-- 
2.40.1


