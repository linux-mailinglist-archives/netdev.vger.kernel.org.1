Return-Path: <netdev+bounces-265104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAmKESzLq2n7gwEAu9opvQ
	(envelope-from <netdev+bounces-265104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:52:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6D222A845
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 07:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B78B6304A21E
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 06:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61AF3387569;
	Sat,  7 Mar 2026 06:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chDbUc/n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21721387576
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865894; cv=none; b=iggIoHGNbBZjSdNuqCB5XEjTCaU+72tsZTYd5wxDcUwtfi8zghwn5TfzC1HLyf0jGb/3tphKsPr0/VuA50X90jtfA75LjrRi1CJv0UaZ5UysyRiOVo8gbtK45CZn/l9HuPnVZX5ENBupf7i+2d3h9b9TIr4Rg1b2HZrUCe/Qqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865894; c=relaxed/simple;
	bh=KHD6ujHLbb4Hg9pj7XHPUSRlHVBVaOw9dccm0+vGtKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AObSug5U9CRAeKCYo3FCj96Z+Kf7TflOJM0xyWP0kEFMelCwmFCf4iXBh2iW7m3bJ9U2Fhh4rhVbNGFFDL60D1pShEk9MyN/9rvhdry/REnHhhyAeAsApXgea9OsXItkTHmWRXupqQW9YxJut1i/Tkyu0TpLx8vm74mp8oyqPwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chDbUc/n; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ad21f437eeso71566455ad.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 22:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865892; x=1773470692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHYg6MzrYh/5hr4XsEQrWa2Q0VlX4ynIFdBuYa9PVdg=;
        b=chDbUc/n/5QSHL7unrNoMsjbUWGtdH4+bvzGnCJle8N0tQtMBhz0iScFdsnYds5EAI
         BAKtywtvywHbnMrT47decXUV1jg/FjyK7FX1RIeYDMCkcF39YYTuSlnSXl/YJiK2Xkd9
         Surhz0R6j4iftDY+El1I+19avidpDW81LItlYGvWRM0IGinrU4SWiGQMZbq7C9WiO4JX
         8pEF+/WuDDG6ymtnPU8OKfOhzlOIBHJdUYzu4N1j5j44qZe3Ohg6gfRTWReza+CsW2eJ
         CIxbrVJv2UoboT49QIyBYQqlxRcGzxE1C224vx6DjZaxqQecY0gs99t55KkNFPCffUK8
         5kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865892; x=1773470692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHYg6MzrYh/5hr4XsEQrWa2Q0VlX4ynIFdBuYa9PVdg=;
        b=CkApy4VO4BnHFXhCTMgrW5PMlfj5i7EMxh7rO2TUZoi1hMSDT/HEWezPwgoqaD3jEO
         sVKoS68QLSmv59ZNEg7LphRFCFNpfsWbddPSwYc+/guYENU3FDYYJoHBmIyLnSyuUMLO
         aEMsbLWHBJfLq/pBs24b4DcCry+P/rM2iWhqbBlzv0lhtrDDW9uNzDXyTssa/OLGjUKK
         M0NQtjX/D8OH3XJYOobizo91aB8gzUAkOM9vmZ8GsWi1TTKjNfcVoIwojiwQ8bqZGx1V
         6xEuZ260sBAs8sYea14uuPeuOdqlSqC07Eru0a/Rek2cWjkeQZiwe+GNDzVZVVKUp1Cl
         AoIg==
X-Gm-Message-State: AOJu0Yx5NzZ4jMQFDms0Bn6bokk1xRPxOwaZ4XiQZuFzrU0H+r9d5Pfn
	tnGYlM9iqDf6/s3Ky3Pedzw1zm2VbVZGQTH03St1D19APW2wQgWVir9mUH/v7A==
X-Gm-Gg: ATEYQzxF+XjqzjmNQHo0aPDWeEXUZpg1nYA8iKgTFGFsuCb7LHGr1+Q5UWqLpiAB4B/
	RkKM8z43wulnYsmLgSpB8+8UyZe/b6rZXPBg6CNjp6mtPC3ScH3faFPkZE0nK5+quToYzI8ZnCs
	CEwK5f+z1o+sBQYNOvS8/sv9BzQIH6cv9JRkYkMZiHBcsX+ve9CqO0eAMkn//xldPBBmyBHr8tT
	vRwtjXibdUym9NQFmf1QUP9rt4cef4FWZUshKAmhtsx6LRHTVpttxKzqO9Ek9mrTvpJkHujqMpj
	51CLf/E+PGk2+lJIOm+rnF3RyPzD2Z1YA05TSQnEopSnbLgPemFWyv6NB85XoHqxuIHDiAjosDb
	nCvDYWG20/zlbIemPMuWgoU0jZjAozymPBaFJTBOAB6d/iBWI3q9+D7PWIV7CP7e5Pg0niwazrx
	2lO8WeubnGP+h8CBfyZq6wnHk=
X-Received: by 2002:a17:902:e808:b0:2ae:478f:2ef with SMTP id d9443c01a7336-2ae82a7b56amr44917185ad.28.1772865892573;
        Fri, 06 Mar 2026 22:44:52 -0800 (PST)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f74e7bsm39861445ad.46.2026.03.06.22.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:52 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 11/11] selftests/bpf: Test using file dynptr after the reference on file is dropped
Date: Fri,  6 Mar 2026 22:44:39 -0800
Message-ID: <20260307064439.3247440-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307064439.3247440-1-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EE6D222A845
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265104-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

File dynptr and slice should be invalidated when the parent file's
reference is dropped in the program. Without the verifier tracking
dyntpr's parent referenced object, the dynptr would continute to be
incorrectly used even if the underlying file is being tear down or gone.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/file_reader_fail.c    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
index 32fe28ed2439..a7102737abfe 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -50,3 +50,63 @@ int xdp_no_dynptr_type(struct xdp_md *xdp)
 	bpf_dynptr_file_discard(&dynptr);
 	return 0;
 }
+
+SEC("lsm/file_open")
+__failure
+__msg("Expected an initialized dynptr as arg #2")
+int use_file_dynptr_after_put_file(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+	char buf[64];
+
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	bpf_put_file(file);
+
+	/* this should fail - dynptr is invalid after file ref is dropped */
+	bpf_dynptr_read(buf, sizeof(buf), &dynptr, 0, 0);
+	return 0;
+
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	return 0;
+}
+
+SEC("lsm/file_open")
+__failure
+__msg("invalid mem access 'scalar'")
+int use_file_dynptr_slice_after_put_file(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+	char *data;
+
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	data = bpf_dynptr_data(&dynptr, 0, 1);
+	if (!data)
+		goto out;
+
+	bpf_put_file(file);
+
+	/* this should fail - data slice is invalid after file ref is dropped */
+	*data = 'x';
+	return 0;
+
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	return 0;
+}
-- 
2.47.3


