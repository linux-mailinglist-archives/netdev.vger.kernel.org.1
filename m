Return-Path: <netdev+bounces-54016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F118059DD
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA83B2104A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F047960BB1;
	Tue,  5 Dec 2023 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvEJJOfD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749019E
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 08:18:44 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db98b9c0fceso862146276.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 08:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701793123; x=1702397923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BURvPLJQRlzgoAyTGarMDZOkoy13Q1y20iI4nRWgWK0=;
        b=FvEJJOfDvDR+CrBewLXFqStaYwk0Sc+7B9FWTOfGUHO57CclyvipjutgfmmN1StQke
         GtEXtG08BqubPEt12+NI7bMCkch7S7X1+DO4r5yRw14RwfwVHxSUJZQdwKdsU50r027t
         FFgkuKcbbyhVNaVHSl9EnhuNeYVlsYxloRoIHtaRzn10OgLGdCgSawFpq+Pf7jjJ65l0
         aCr25EJ8X3q1mz+/3TPHrfcbz/mLxE8+gWHAn1BBqyPJjCynsVXsOfIrAoP0ItFWlqnp
         ugMIpcy2gJsfqVWSEw77vUxnxqUvKvZEcxTQG3bkri62waAsyrQN4eexwjRPDtdp9U88
         fa/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701793123; x=1702397923;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BURvPLJQRlzgoAyTGarMDZOkoy13Q1y20iI4nRWgWK0=;
        b=M2eVu7uJc8MEqG0u0LHU1nmuvgr86OES1nCmQGNtdko0Qfk8eaAo8HU/MjBWfnceZ+
         YejiOMUU7xOjTEkmR+PiCgnTjQ8iDvalg/+ZlwZuSaOpd31p5o+xhMOOGhd0ydXOSHl6
         l8VPPf+v//vWXGm0YxxTj8noBPnFgfBJScZH+Ozl4N7PctPw6gqtkxPQIjsw4OyUvtf8
         LUMIo4HYBX8OnD2ED+1j8m0I0dmhPvz8EHqW1GYAQAoiHyPPfoix/0CGoFqQDeszvoSR
         gIIPjNK3hgi6sf+dJQcg4ti6h+orNNhuGXvvkcPbso+xpur6ypjLS+50YuFCE4clBasD
         Qkyw==
X-Gm-Message-State: AOJu0YyPOMYyhNsA+ORu5YoBInq85tHATgIyox3pfM7/D3nc/lvHzmdn
	t/Ms7D+VA7llAyuhe8urevE+kEIOtOsPhA==
X-Google-Smtp-Source: AGHT+IHR7w6ttbJsge5QDeneFHLWyUOM5OJ97ws818XJtGM0Tv3ADIuH58jWuICTFfIMaRYjcZQCXrV4oXlBlg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d6d1:0:b0:db7:dce9:76d3 with SMTP id
 n200-20020a25d6d1000000b00db7dce976d3mr195018ybg.9.1701793123586; Tue, 05 Dec
 2023 08:18:43 -0800 (PST)
Date: Tue,  5 Dec 2023 16:18:41 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231205161841.2702925-1-edumazet@google.com>
Subject: [PATCH net] tcp: do not accept ACK of bytes we never sent
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Neal Cardwell <ncardwell@google.com>, Yuchung Cheng <ycheng@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Yepeng Pan <yepeng.pan@cispa.de>, 
	Christian Rossow <rossow@cispa.de>
Content-Type: text/plain; charset="UTF-8"

This patch is based on a detailed report and ideas from Yepeng Pan
and Christian Rossow.

ACK seq validation is currently following RFC 5961 5.2 guidelines:

   The ACK value is considered acceptable only if
   it is in the range of ((SND.UNA - MAX.SND.WND) <= SEG.ACK <=
   SND.NXT).  All incoming segments whose ACK value doesn't satisfy the
   above condition MUST be discarded and an ACK sent back.  It needs to
   be noted that RFC 793 on page 72 (fifth check) says: "If the ACK is a
   duplicate (SEG.ACK < SND.UNA), it can be ignored.  If the ACK
   acknowledges something not yet sent (SEG.ACK > SND.NXT) then send an
   ACK, drop the segment, and return".  The "ignored" above implies that
   the processing of the incoming data segment continues, which means
   the ACK value is treated as acceptable.  This mitigation makes the
   ACK check more stringent since any ACK < SND.UNA wouldn't be
   accepted, instead only ACKs that are in the range ((SND.UNA -
   MAX.SND.WND) <= SEG.ACK <= SND.NXT) get through.

This can be refined for new (and possibly spoofed) flows,
by not accepting ACK for bytes that were never sent.

This greatly improves TCP security at a little cost.

I added a Fixes: tag to make sure this patch will reach stable trees,
even if the 'blamed' patch was adhering to the RFC.

tp->bytes_acked was added in linux-4.2

Following packetdrill test (courtesy of Yepeng Pan) shows
the issue at hand:

0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+0 bind(3, ..., ...) = 0
+0 listen(3, 1024) = 0

// ---------------- Handshake ------------------- //

// when window scale is set to 14 the window size can be extended to
// 65535 * (2^14) = 1073725440. Linux would accept an ACK packet
// with ack number in (Server_ISN+1-1073725440. Server_ISN+1)
// ,though this ack number acknowledges some data never
// sent by the server.

+0 < S 0:0(0) win 65535 <mss 1400,nop,wscale 14>
+0 > S. 0:0(0) ack 1 <...>
+0 < . 1:1(0) ack 1 win 65535
+0 accept(3, ..., ...) = 4

// For the established connection, we send an ACK packet,
// the ack packet uses ack number 1 - 1073725300 + 2^32,
// where 2^32 is used to wrap around.
// Note: we used 1073725300 instead of 1073725440 to avoid possible
// edge cases.
// 1 - 1073725300 + 2^32 = 3221241997

// Oops, old kernels happily accept this packet.
+0 < . 1:1001(1000) ack 3221241997 win 65535

// After the kernel fix the following will be replaced by a challenge ACK,
// and prior malicious frame would be dropped.
+0 > . 1:1(0) ack 1001

Fixes: 354e4aa391ed ("tcp: RFC 5961 5.2 Blind Data Injection Attack Mitigation")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Yepeng Pan <yepeng.pan@cispa.de>
Reported-by: Christian Rossow <rossow@cispa.de>
---
 net/ipv4/tcp_input.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index bcb55d98004c5213f0095613124d5193b15b2793..62cccc2e89ec68b3badae03168f1bfcd2698e0b7 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3871,8 +3871,12 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	 * then we can probably ignore it.
 	 */
 	if (before(ack, prior_snd_una)) {
+		u32 max_window;
+
+		/* do not accept ACK for bytes we never sent. */
+		max_window = min_t(u64, tp->max_window, tp->bytes_acked);
 		/* RFC 5961 5.2 [Blind Data Injection Attack].[Mitigation] */
-		if (before(ack, prior_snd_una - tp->max_window)) {
+		if (before(ack, prior_snd_una - max_window)) {
 			if (!(flag & FLAG_NO_CHALLENGE_ACK))
 				tcp_send_challenge_ack(sk);
 			return -SKB_DROP_REASON_TCP_TOO_OLD_ACK;
-- 
2.43.0.rc2.451.g8631bc7472-goog


