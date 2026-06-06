Return-Path: <netdev+bounces-296063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 45/LB0m7I2ofxgEAu9opvQ
	(envelope-from <netdev+bounces-296063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 08:16:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DEB64CB1E
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 08:16:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=a3xZMcf8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296063-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296063-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6DED303CEA5
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 06:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B455030C150;
	Sat,  6 Jun 2026 06:13:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D983064B2
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 06:13:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780726383; cv=none; b=JdV+Fhj5Dopl+EOT6Wp8tFYDMJl+HoHoqWFQcExF7i7sHJd8SiqmEEPgtezbuL64SJKdJ2b5zp9d6CYlNGMjBjyx9ELcRryYTR5syqARVDQ8CVu2Riolk99n6pqYmXGYatdOzIF2CbP2vWApwM0M3Y/+Am9POSdvH8oA/FUarm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780726383; c=relaxed/simple;
	bh=YVkMCLt5FJ+bDbSrJETzwIU6LK60EPUbwXQNXghAHuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrdxfFWfoXwbOQ7UotFmmkPGclxQqqH0OLt+EZslPD4M50ekj/rAnHvjS2RKip0YJ5/cYqeYwITh/KqKIugcEdFeaWsVjhrgUGiOfuIOAyEBbiy3UvmPRJPHbKoY4aIUIYl/EoGmiyvW5QMlIKJ5PqLO2wWAQ8GcfVAS6XTcQCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3xZMcf8; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490ac10e337so22722115e9.3
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 23:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780726380; x=1781331180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y22J8nzR3UW0cMYCUVJWDcFSFo/6kHGVqnn/SzRaSz8=;
        b=a3xZMcf8qDs8ViQFPPN8nYKAL1Op8FOTL/SEYz+j1qU9fOehiv6gerL8Z0EuCjr4jv
         HzRypJdpqmObxKso9mHsn0g15GTjR0XBAXyZOHh55yoB6XxDYd59DipPJSNqDxEaU/4Q
         BMZB8INnMZ8T2et5vzOaY/Ox69qyHqWVIlFmtUZvFSypmvFetmxSsORTT45UGHl3FIaS
         VGInaZScHjTqHPwDX9yC2gAVV9Ze7OQmsjKVlAHASkvxpN9gLrP4jRy2teo2R13z4Qj6
         HVDS/mFAmPPxrQVADHYbsjFn6nbs3Sb2c2X0GaCNQDspHIGHhAFhtODEvC8n631oljsK
         GarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780726380; x=1781331180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y22J8nzR3UW0cMYCUVJWDcFSFo/6kHGVqnn/SzRaSz8=;
        b=LLCemyeFlsHbzod6OlAz1CiBq7B5FLiYK09n/BIGWeLhoxATRtuu55C4m/Fbtq6vsC
         Zuejj3At9VJdC0pHffbHyI0MMNTLzu5YLWlVH4K4DaBUJyQR5OEA9B7fhev827Skf4JN
         lvCtT/xSvgcTWimslw0RT1bKiMZfEIAOGxCaZiyR+LAw98Zgvnuc8+aOrbsKLDSagOLo
         fyL7jTvFCQu9Mt5E4wbY2bFBGTr9JbjadIP1QP4oR8zkTV1fpUaJZpi09GuPis+t2UjK
         0lUG6KLW/EnCi6JA9/6954vRTnFEdDtZ1TFsTihy1THRKhL9aIIEy2JBFXikt7btdgxB
         vgtw==
X-Forwarded-Encrypted: i=1; AFNElJ/pZtbhMCp6JqZYyPxWdWPP9YsQw4+iB05SDnu2mnGFSfkl3AXUEOGqBhyXz6hAvQRvytEgMog=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqNpIzjJkERUsROUDMic1i5vS33zwj7V8pA6VGLAfTRcOBjvZU
	qz6NpnWymlvoW12ET4jA4ON4WogYSabss/f4LeyS9MeozFOqGpH+cTtC
X-Gm-Gg: Acq92OFKM//Y3CsfLL9FKAvsF/Mci3PKKDeqXVvUFMJyyWqVfLltapc7NHn6cnA4ko+
	+oVwP0lBjuCLmuj47lCuKoM5BGeGlBlU3fLtNGd6wlhvnM7H2O3rs4jx4XD2EsD1/MyH+Cg+qo7
	GCiqmRPp5fLe80WeD8du5GtGNnYBb7+5s4TNs6c7ocRSVXatoj8MZT4YoO37cSlA1HHtcD1yRMq
	qNavcLlfYn+LV2ZPVCWpzYPHuL/ubCxIdctCYeAFoUs4UjVO8cp+vs0l5HgSK/0K1tqwc/+y3hL
	OPlt/f6RHyXxugOF57gK+HKJx4S7bHuw/wnPggaWUxlbNcs2mNGFah6QPsCh8xbb7MyU37i45uI
	GFQcW8VW+j4iaT/NB/gcUbrGCbeMyZtAsmLDJzXJrk/6H7eQZlM0jvASRQUlNJALtUjxm+QmGRP
	pQzC443IBJEwPe2S5XkJW0GjYXmDaLIQ==
X-Received: by 2002:a05:600c:c0d3:b0:490:b0e0:3de2 with SMTP id 5b1f17b1804b1-490c265c148mr78044605e9.33.1780726380490;
        Fri, 05 Jun 2026 23:13:00 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f2eadefsm32281391f8f.11.2026.06.05.23.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 23:13:00 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-api@vger.kernel.org,
	netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	ltp@lists.linux.it,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Andy Lutomirski <luto@amacapital.net>,
	Collin Funk <collin.funk1@gmail.com>,
	David Laight <david.laight.linux@gmail.com>,
	Stefan Metzmacher <metze@samba.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	The 8472 <kernel@infinite-source.de>,
	Willy Tarreau <w@1wt.eu>,
	Joanne Koong <joannelkoong@gmail.com>,
	patches@lists.linux.dev
Subject: [PATCH 5/5] vmsplice: make sure we don't wait after writing some data
Date: Sat,  6 Jun 2026 06:10:31 +0000
Message-ID: <20260606061031.3744880-6-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260606061031.3744880-1-safinaskar@gmail.com>
References: <20260606061031.3744880-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296063-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-fsdevel@vger.kernel.org,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:fuse-devel@lists.linux.dev,m:ltp@lists.linux.it,m:torvalds@linux-foundation.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:luto@amacapital.net,m:collin.funk1@gmail.com,m:david.laight.linux@gmail.com,m:metze@samba.org,m:rostedt@goodmis.org,m:kernel@infinite-source.de,m:w@1wt.eu,m:joannelkoong@gmail.com,m:patches@lists.linux.dev,m:collinfunk1@gmail.com,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,lists.linux.dev,lists.linux.it,linux-foundation.org,infradead.org,kernel.dk,redhat.com,kernel.org,suse.de,szeredi.hu,amacapital.net,gmail.com,samba.org,goodmis.org,infinite-source.de,1wt.eu];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75DEB64CB1E

Make sure we don't wait for space in pipe after writing some data.
This is needed for compatibility with previous version of vmsplice.
Found by LTP vmsplice01.
See comments in the code and links below for details.

Link: https://lore.kernel.org/all/20260603-raumfahrt-unmerklich-ertrugen-c4ecae70d5f9@brauner/
Link: https://lore.kernel.org/all/CAHk-=wgV-j-G3d+899Zm1pQ=NaJrddPz=GKcL5Yw5DTUM=GaUw@mail.gmail.com/
Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/read_write.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 77487b307..dbd0debc2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1221,6 +1221,8 @@ SYSCALL_DEFINE6(pwritev2, unsigned long, fd, const struct iovec __user *, vec,
 SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, vec,
 		unsigned long, vlen, unsigned int, flags)
 {
+	struct pipe_inode_info *pipe;
+
 	if (unlikely(flags & ~SPLICE_F_ALL))
 		return -EINVAL;
 
@@ -1229,11 +1231,44 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, vec,
 		return -EBADF;
 
 	/* We do vfs_writev/vfs_readv, so it is okay to pass "false" here */
-	if (!get_pipe_info(fd_file(f), /* for_splice = */ false))
+	pipe = get_pipe_info(fd_file(f), /* for_splice = */ false);
+
+	if (!pipe)
 		return -EBADF;
 
 	if (fd_file(f)->f_mode & FMODE_WRITE) {
-		ssize_t ret = vfs_writev(fd_file(f), vec, vlen, NULL, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+		/*
+		 * When writing to the pipe, previous implementation of vmsplice
+		 * first waited for space in the pipe to appear
+		 * (depending on whether SPLICE_F_NONBLOCK was passed),
+		 * then did unconditional non-blocking write to the pipe.
+		 *
+		 * This differs from what pwritev2 does.
+		 *
+		 * For compatibility we do the same thing previous
+		 * implementation did.
+		 *
+		 * We lock the pipe, do pipe_wait_for_space, then unlock
+		 * the pipe, and then do vfs_writev. vfs_writev internally
+		 * locks the pipe again. This may cause TOCTOU: when we
+		 * do vfs_writev, the pipe may become full again. So we
+		 * do a loop.
+		 */
+
+		bool non_block = (flags & SPLICE_F_NONBLOCK) || (fd_file(f)->f_flags & O_NONBLOCK);
+		ssize_t ret;
+
+		do {
+			pipe_lock(pipe);
+			ret = pipe_wait_for_space(pipe, non_block);
+			pipe_unlock(pipe);
+
+			if (ret < 0)
+				break;
+
+			ret = vfs_writev(fd_file(f), vec, vlen, NULL, RWF_NOWAIT);
+		} while (!non_block && ret == -EAGAIN);
+
 		if (ret > 0)
 			add_wchar(current, ret);
 		inc_syscw(current);
-- 
2.47.3


