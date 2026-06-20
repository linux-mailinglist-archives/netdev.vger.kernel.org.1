Return-Path: <netdev+bounces-300822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z9Q+BYetNmotDAcAu9opvQ
	(envelope-from <netdev+bounces-300822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:11:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 716C86A90EC
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 17:11:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bvGxtRUO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300822-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300822-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC6F5301372C
	for <lists+netdev@lfdr.de>; Sat, 20 Jun 2026 15:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0D0396B6F;
	Sat, 20 Jun 2026 15:10:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6717395DAC
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 15:10:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781968259; cv=none; b=hEBse8Q0HxYlI10XtkV/ytPyDJrdPCB/AEAXj5+LzE6rdGXEoc+FPOwobh31L6mYK9u1GYLz3nO49nflcRKt8YAnGsIY2x9FeGrXfhy9cgGdMQwsQTpnLPPmGpBepmGt+qqLDILaNHoNDXAe9dfbJkRRpRaEAN+KnPBwT6nODZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781968259; c=relaxed/simple;
	bh=nM9bCXK3N/lq6TM2lsXDXTNL1v0ITcN7gA/rt5hbbVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBggNanq/yi84U3HssgbdGBftEgRnEUx7HAPNTM2r+NgwRfo0cUm2/n2GqAI3IeQXqJKhpFtSKM5CEn+CojtX6eS5HrGjwZjziNaJGc9R1oEjjgWmi/hDeGxdsBGI5jw8cb0J+C4LUy1mEWZtQ6GKhZ6v7LoxaqDe/44V7fj3rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvGxtRUO; arc=none smtp.client-ip=209.85.219.44
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8dc544dda2fso27085186d6.1
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781968257; x=1782573057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzA9ScnXVH8tConPvNNlqSftFL+N4sg+bX/Nnsu2/ck=;
        b=bvGxtRUOsZe+e8eNF/QSctuiVkQr0wqY0yr11iahe1v/9eO8zHEngMne5yci2Xq1y0
         aZVX0aDk0JUfuNbnC8FUG63/lW3M5MK96/X/uE3ORaPPR94OfliECDLKFk2xqzeB9GWN
         9epXEWrLTlcbl5pCNrWqsRSx5UVXj/amX4al1UVb7tcs7VVc0XgWRO4qM8PP098lfcBC
         Nz3/TrscUA230XE14bHTUyRY4iYmUGvAFrttgFrbJyHgUV+W2DFEaRrYqY1r88Tv4EGR
         kg8CEUONyPGpxIvy46Ilkfz0jlXCIQKTAH8sXw9Gcos4Q8iIZototLYS7aey83Xzit2f
         xZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781968257; x=1782573057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FzA9ScnXVH8tConPvNNlqSftFL+N4sg+bX/Nnsu2/ck=;
        b=fy+MaWIeW3OTrLNS+GLYMgQ0m4xD0AKVQtFEVc8UeEn8oMPYbTA1G/hwTqLEjkT3hq
         J6i4P2ht7uBJZWvK0l7IIMCIrW15lXkD+sQqktQh3dxyGcCAh9zobwsJbvkW7iX+Uid2
         5YMErluQnynfKYYMEYGZdLFxUlVhTc55AOoN2XpOnBbgFM/SYH6wkvSV9H430Y5vjbqB
         dZH4ZflcXRqS86hWcxUvCev/hUhGJFpaoSOhcb4whLgQO60jXtSDJ+rI/rNZfJ6Jst+1
         JYceL4TByM4HkFMLhWWDazHqxpHWDJifpkzf6tTY5eTFL9IaTdyajD3Us2nftjfxBtp8
         is8Q==
X-Gm-Message-State: AOJu0YzKTCpCMJMdlg82rvXDlxM97ywk/D1go/9rAoMIMgS1RDV2JwNv
	Yvn3zStTDkrbH0SJZ5qvV8eRCeTo3/G1wS24yepEF8djLBJeFcT5e4p+zGcu0g==
X-Gm-Gg: AfdE7clsLp9B9WpJ+8tteLeK9wxmvlliVo2pM30pn+vy0IYK9JBiJu71yNcOqND3gYr
	9v7M1Z7qpHLTbycDiH5m2BFWKhzuUTD2kFFU5gBDDv2wIsfoO135jASGvoW2QxX52keLkalZ10e
	0fdbofDTNERWrKYhK2ofMMnjgBNRlLFpek7AVmvyoDxfIzTzf2x+2cqWvoaEQjb1kPRbdNeK7dY
	gl5vrFM0rpuwVP9EV3A3iS6X0teaRGXGyOOQ54J0Gs6Kqzj63/b7JbfhdStyuY0gnKQ/8ETc3J1
	w8dZ6ouO8/qKIOQwr9Mcm/fD1lY4FH+RBQU4ELi1XRm4WMdW0K36yS9V8sEMjY3OmWuztxrja7F
	Fke1F0VqVIuFcXxiR6peJWhj623XoYOGbKoW+K5zz8JNtDGbENzDRAWV1b868GneBBn861NPf8z
	DDg981Oq1lJyKS9K4Cw/PT5E/MsFMhfKtAq0mwaVRCUp8n2aesUwoQNsDvhpixBdyEowye/kW9B
	QM4EDXgJEKo763vSHkROwtPlLmw0fk7kVxQHUlGQdDvY9LCS7vFJTafoAj+czZv1Q==
X-Received: by 2002:a05:6214:1308:b0:8e0:6eca:ba7f with SMTP id 6a1803df08f44-8e06ecabac5mr24066146d6.40.1781968256538;
        Sat, 20 Jun 2026 08:10:56 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cde21csm34402146d6.26.2026.06.20.08.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 08:10:55 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: [PATCH net v2 1/2] sctp: factor out INIT verification failure handling
Date: Sat, 20 Jun 2026 11:09:21 -0400
Message-ID: <afa5f899e970da8efb28013293ec63fa19cd47b4.1781968162.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1781968162.git.lucien.xin@gmail.com>
References: <cover.1781968162.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-300822-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 716C86A90EC

Extract the duplicated INIT/INIT-ACK error handling logic into a new
helper, sctp_abort_on_init_err().

Several state functions open-code the same pattern after
sctp_verify_init() fails: construct an ABORT with error causes if
available, send it when allocation succeeds, or fall back to T-bit ABORT
handling when no error chunk is present. INIT-ACK handling also includes
additional teardown logic for malformed packets.

Move this logic into sctp_abort_on_init_err() to reduce duplication and
centralize INIT/INIT-ACK failure handling.

No functional change intended. The helper will be used in a subsequent
patch.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
v2:
  - Pass cid to sctp_abort_on_init_err().
  - Delete chunk param from sctp_abort_on_init_err() and get chunk from
    arg param.
  - Jump to label 'out:' when err_chunk is NULL and cid is INIT_ACK in
    sctp_abort_on_init_err(), noted by Sashiko.
---
 net/sctp/sm_statefuns.c | 187 ++++++++++++++++++----------------------
 1 file changed, 85 insertions(+), 102 deletions(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 9b23c11cbb9e..8c636f045e45 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -68,6 +68,13 @@ static void sctp_send_stale_cookie_err(struct net *net,
 				       const struct sctp_chunk *chunk,
 				       struct sctp_cmd_seq *commands,
 				       struct sctp_chunk *err_chunk);
+static enum sctp_disposition sctp_abort_on_init_err(
+					struct net *net,
+					const struct sctp_endpoint *ep,
+					const struct sctp_association *asoc,
+					enum sctp_cid cid, void *arg,
+					struct sctp_cmd_seq *commands,
+					struct sctp_chunk *err_chunk);
 static enum sctp_disposition sctp_sf_do_5_2_6_stale(
 					struct net *net,
 					const struct sctp_endpoint *ep,
@@ -325,7 +332,7 @@ enum sctp_disposition sctp_sf_do_5_1B_init(struct net *net,
 	struct sctp_chunk *chunk = arg, *repl, *err_chunk;
 	struct sctp_unrecognized_param *unk_param;
 	struct sctp_association *new_asoc;
-	struct sctp_packet *packet;
+	enum sctp_cid cid;
 	int len;
 
 	/* 6.10 Bundling
@@ -373,34 +380,12 @@ enum sctp_disposition sctp_sf_do_5_1B_init(struct net *net,
 
 	/* Verify the INIT chunk before processing it. */
 	err_chunk = NULL;
-	if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
+	cid = chunk->chunk_hdr->type;
+	if (!sctp_verify_init(net, ep, asoc, cid,
 			      (struct sctp_init_chunk *)chunk->chunk_hdr, chunk,
-			      &err_chunk)) {
-		/* This chunk contains fatal error. It is to be discarded.
-		 * Send an ABORT, with causes if there is any.
-		 */
-		if (err_chunk) {
-			packet = sctp_abort_pkt_new(net, ep, asoc, arg,
-					(__u8 *)(err_chunk->chunk_hdr) +
-					sizeof(struct sctp_chunkhdr),
-					ntohs(err_chunk->chunk_hdr->length) -
-					sizeof(struct sctp_chunkhdr));
-
-			sctp_chunk_free(err_chunk);
-
-			if (packet) {
-				sctp_add_cmd_sf(commands, SCTP_CMD_SEND_PKT,
-						SCTP_PACKET(packet));
-				SCTP_INC_STATS(net, SCTP_MIB_OUTCTRLCHUNKS);
-				return SCTP_DISPOSITION_CONSUME;
-			} else {
-				return SCTP_DISPOSITION_NOMEM;
-			}
-		} else {
-			return sctp_sf_tabort_8_4_8(net, ep, asoc, type, arg,
-						    commands);
-		}
-	}
+			      &err_chunk))
+		return sctp_abort_on_init_err(net, ep, asoc, cid, arg, commands,
+					      err_chunk);
 
 	/* Grab the INIT header.  */
 	chunk->subh.init_hdr = (struct sctp_inithdr *)chunk->skb->data;
@@ -525,7 +510,7 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
 	struct sctp_init_chunk *initchunk;
 	struct sctp_chunk *chunk = arg;
 	struct sctp_chunk *err_chunk;
-	struct sctp_packet *packet;
+	enum sctp_cid cid;
 
 	if (!sctp_vtag_verify(chunk, asoc))
 		return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
@@ -546,52 +531,12 @@ enum sctp_disposition sctp_sf_do_5_1C_ack(struct net *net,
 
 	/* Verify the INIT chunk before processing it. */
 	err_chunk = NULL;
-	if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
+	cid = chunk->chunk_hdr->type;
+	if (!sctp_verify_init(net, ep, asoc, cid,
 			      (struct sctp_init_chunk *)chunk->chunk_hdr, chunk,
-			      &err_chunk)) {
-
-		enum sctp_error error = SCTP_ERROR_NO_RESOURCE;
-
-		/* This chunk contains fatal error. It is to be discarded.
-		 * Send an ABORT, with causes.  If there are no causes,
-		 * then there wasn't enough memory.  Just terminate
-		 * the association.
-		 */
-		if (err_chunk) {
-			packet = sctp_abort_pkt_new(net, ep, asoc, arg,
-					(__u8 *)(err_chunk->chunk_hdr) +
-					sizeof(struct sctp_chunkhdr),
-					ntohs(err_chunk->chunk_hdr->length) -
-					sizeof(struct sctp_chunkhdr));
-
-			sctp_chunk_free(err_chunk);
-
-			if (packet) {
-				sctp_add_cmd_sf(commands, SCTP_CMD_SEND_PKT,
-						SCTP_PACKET(packet));
-				SCTP_INC_STATS(net, SCTP_MIB_OUTCTRLCHUNKS);
-				error = SCTP_ERROR_INV_PARAM;
-			}
-		}
-
-		/* SCTP-AUTH, Section 6.3:
-		 *    It should be noted that if the receiver wants to tear
-		 *    down an association in an authenticated way only, the
-		 *    handling of malformed packets should not result in
-		 *    tearing down the association.
-		 *
-		 * This means that if we only want to abort associations
-		 * in an authenticated way (i.e AUTH+ABORT), then we
-		 * can't destroy this association just because the packet
-		 * was malformed.
-		 */
-		if (sctp_auth_recv_cid(SCTP_CID_ABORT, asoc))
-			return sctp_sf_pdiscard(net, ep, asoc, type, arg, commands);
-
-		SCTP_INC_STATS(net, SCTP_MIB_ABORTEDS);
-		return sctp_stop_t1_and_abort(net, commands, error, ECONNREFUSED,
-						asoc, chunk->transport);
-	}
+			      &err_chunk))
+		return sctp_abort_on_init_err(net, ep, asoc, cid, arg, commands,
+					      err_chunk);
 
 	/* Tag the variable length parameters.  Note that we never
 	 * convert the parameters in an INIT chunk.
@@ -1522,7 +1467,7 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 	struct sctp_unrecognized_param *unk_param;
 	struct sctp_association *new_asoc;
 	enum sctp_disposition retval;
-	struct sctp_packet *packet;
+	enum sctp_cid cid;
 	int len;
 
 	/* 6.10 Bundling
@@ -1564,33 +1509,12 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 
 	/* Verify the INIT chunk before processing it. */
 	err_chunk = NULL;
-	if (!sctp_verify_init(net, ep, asoc, chunk->chunk_hdr->type,
+	cid = chunk->chunk_hdr->type;
+	if (!sctp_verify_init(net, ep, asoc, cid,
 			      (struct sctp_init_chunk *)chunk->chunk_hdr, chunk,
-			      &err_chunk)) {
-		/* This chunk contains fatal error. It is to be discarded.
-		 * Send an ABORT, with causes if there is any.
-		 */
-		if (err_chunk) {
-			packet = sctp_abort_pkt_new(net, ep, asoc, arg,
-					(__u8 *)(err_chunk->chunk_hdr) +
-					sizeof(struct sctp_chunkhdr),
-					ntohs(err_chunk->chunk_hdr->length) -
-					sizeof(struct sctp_chunkhdr));
-
-			if (packet) {
-				sctp_add_cmd_sf(commands, SCTP_CMD_SEND_PKT,
-						SCTP_PACKET(packet));
-				SCTP_INC_STATS(net, SCTP_MIB_OUTCTRLCHUNKS);
-				retval = SCTP_DISPOSITION_CONSUME;
-			} else {
-				retval = SCTP_DISPOSITION_NOMEM;
-			}
-			goto cleanup;
-		} else {
-			return sctp_sf_tabort_8_4_8(net, ep, asoc, type, arg,
-						    commands);
-		}
-	}
+			      &err_chunk))
+		return sctp_abort_on_init_err(net, ep, asoc, cid, arg, commands,
+					      err_chunk);
 
 	/*
 	 * Other parameters for the endpoint SHOULD be copied from the
@@ -1691,7 +1615,6 @@ static enum sctp_disposition sctp_sf_do_unexpected_init(
 nomem_retval:
 	if (new_asoc)
 		sctp_association_free(new_asoc);
-cleanup:
 	if (err_chunk)
 		sctp_chunk_free(err_chunk);
 	return retval;
@@ -6485,6 +6408,66 @@ static void sctp_send_stale_cookie_err(struct net *net,
 	}
 }
 
+static enum sctp_disposition sctp_abort_on_init_err(
+					struct net *net,
+					const struct sctp_endpoint *ep,
+					const struct sctp_association *asoc,
+					enum sctp_cid cid, void *arg,
+					struct sctp_cmd_seq *commands,
+					struct sctp_chunk *err_chunk)
+{
+	enum sctp_error error = SCTP_ERROR_NO_RESOURCE;
+	struct sctp_chunk *chunk = arg;
+	struct sctp_packet *packet;
+	struct sctp_chunkhdr *ch;
+
+	if (!err_chunk) {
+		if (cid == SCTP_CID_INIT_ACK)
+			goto out;
+		return sctp_sf_tabort_8_4_8(net, ep, asoc, SCTP_ST_CHUNK(0),
+					    arg, commands);
+	}
+
+	ch = err_chunk->chunk_hdr;
+	packet = sctp_abort_pkt_new(net, ep, asoc, arg,
+				    (__u8 *)ch + sizeof(*ch),
+				    ntohs(ch->length) - sizeof(*ch));
+
+	sctp_chunk_free(err_chunk);
+
+	if (packet) {
+		sctp_add_cmd_sf(commands, SCTP_CMD_SEND_PKT,
+				SCTP_PACKET(packet));
+		SCTP_INC_STATS(net, SCTP_MIB_OUTCTRLCHUNKS);
+		error = SCTP_ERROR_INV_PARAM;
+	}
+
+	if (cid != SCTP_CID_INIT_ACK) {
+		if (!packet)
+			return SCTP_DISPOSITION_NOMEM;
+		return SCTP_DISPOSITION_CONSUME;
+	}
+
+out:
+	/* SCTP-AUTH, Section 6.3:
+	 *    It should be noted that if the receiver wants to tear
+	 *    down an association in an authenticated way only, the
+	 *    handling of malformed packets should not result in
+	 *    tearing down the association.
+	 *
+	 * This means that if we only want to abort associations
+	 * in an authenticated way (i.e AUTH+ABORT), then we
+	 * can't destroy this association just because the packet
+	 * was malformed.
+	 */
+	if (sctp_auth_recv_cid(SCTP_CID_ABORT, asoc))
+		return sctp_sf_pdiscard(net, ep, asoc, SCTP_ST_CHUNK(0), arg,
+					commands);
+
+	SCTP_INC_STATS(net, SCTP_MIB_ABORTEDS);
+	return sctp_stop_t1_and_abort(net, commands, error, ECONNREFUSED,
+				      asoc, chunk->transport);
+}
 
 /* Process a data chunk */
 static int sctp_eat_data(const struct sctp_association *asoc,
-- 
2.47.1


