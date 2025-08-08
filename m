Return-Path: <netdev+bounces-212159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15438B1E7A2
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41A751AA7620
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EF4274FF1;
	Fri,  8 Aug 2025 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWa3LswB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E7627511B;
	Fri,  8 Aug 2025 11:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653527; cv=none; b=cYbm41wY8bPvt7uXJtknOsy8sNToQnKuLJsdkU8CaUU5Y8qllh+yaBARi0gzH4mjJTaDsJSy08sTLUBqTadynXh3tCMQmCuighx8IM1AVflXe2GHJGheYzI1p44YwETxBFszmixgjQUrlz56dDk5hHzk9clHN0iBY9SOApmLlUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653527; c=relaxed/simple;
	bh=JCb2Wucb597XYc082b4ksWt6U4ItC6OcHtSYOAT0zGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NmH0zkmn+x8NJpGzXA2bijsphPpCYxnw/0EupUainzxjDrw3AmK4cBXF7eQbtf9MEmiy6TEdeAdNjDZnYO2+jatBx7K0lOojyilPc0ZMVk6pyMv8b5yu4E4vIlyM3egMkQqgF1zi70g/iO3Bjba7C2ljjhpIvY4i0dU99+XBrZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWa3LswB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E0BC4CEF1;
	Fri,  8 Aug 2025 11:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754653527;
	bh=JCb2Wucb597XYc082b4ksWt6U4ItC6OcHtSYOAT0zGk=;
	h=From:Date:Subject:To:Cc:From;
	b=YWa3LswBMPnG6NIgv+N6MMXalAQUcMTDUxoZHsSmxG6Crx+BAInZ/SczpOUuNpY4v
	 cPMaap8pGYKlbVavcqpFfqD+tR/pWopQPuhdTJJgEibD75LAgSVCX7LFHmtHurD5GP
	 /6opCenbuLCsm9Hgip+buL4FvzV6g63C1i49FfNXO6g5BCl4vgt4NLHVRQlceccgYh
	 eeVwGsc87LqeBpFPj3SQ3ghsF77dEh46DpFwNQPF78kBjnLrB/HEgdf7TdBwXfE8wZ
	 QEe/eJz2UfOdPniJySrqieBdCj8G+wSBd+twD+pmd9VN5pKYac/11WiKXrjYZ1bCdI
	 vzQuWrdagDS+g==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 08 Aug 2025 07:45:23 -0400
Subject: [PATCH RESEND] ref_tracker: use %p instead of %px in debugfs
 dentry name
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-reftrack-dbgfs-v1-1-106fdd6ed1d1@kernel.org>
X-B4-Tracking: v=1; b=H4sIAFLjlWgC/3WNPw+CMBTEvwp5szUt4J8yOcjqoKNhKO1raTDUv
 BKiIXx3m+7mprtf7m6FiOQxQlOsQLj46MOUjNgVoAc1OWTeJA8lLw/8VAlGaGdSemSmdzYyK6U
 ysuTHc68hld6J+08efMK9fbS3K3QpH3ycA33zzyIy/Te5CJZUV4hCW6Pq+jIiTfjaB3LQbdv2A
 xt4CDa1AAAA
X-Change-ID: 20250731-reftrack-dbgfs-f99ad92068bc
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
Cc: Kees Cook <kees@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JCb2Wucb597XYc082b4ksWt6U4ItC6OcHtSYOAT0zGk=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoleNWegUZnWcCgiILzg2YGGe/stuFlIjuI3lzj
 zmrOEzs6xOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaJXjVgAKCRAADmhBGVaC
 FYq2EACclqogn7yr7vrbxATJAEGvkwEYy8ewzIeU2e+ggU6B8QtcXQOjd+zy006swmzzsYXGdID
 BI7AtD8l2fSm6EmtpPQCiUfzUBd11pIOObADttnwRE0LsBXV+hQ33WN68Gtob4f5XvXIfFHWcrn
 YORDwWgSnAO0MSzgfWxv3fqE2LAh/LjlMYZtcIKpnhrAKXQqy63KepdbrjVvvnXM2I88tGKjRQG
 XEMpp75BompkeLE7eAXd0byO+NR+InjMs3Vek6XrnzH0lbrWequwvuk9U5/TjcwMhqoG97mpaJt
 uI7MNSeT9Qm9t2obZ/AbyLYdo/o456yDB7T2F0hF1x7NvpgChXOW+3WWmNw0sDdq2MXprJ3+i2m
 ibZfW1BxD2AGHtgBwOZOOSWb9fWHcOi/jhEKAhWbXPKw90BTecsSRnwVB597TTCK55dTco6BjVM
 C6DCzBTasN10zQ/fGSiiLpfrp9ZQPpDvwTpmAbVPRI5X0gqYVh/9G8iM9Vl2H3vgCDfGWMpRNus
 qxjsnujR9eYkOSG4x0oFBlY7NGfHTeIponrsZHrQCrh9/2OGBhlzdagCesOVV2toV734O7mbH9j
 tjfz0x7Cb5OrfLRp7weiH5znTRmPpuaBBGJQGS0CTUq1AoFNv4sjwJislTksenGOUodnd9TtGGM
 TMFI+Yj8T5UPn3Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

As Kees points out, this is a kernel address leak, and debugging is
not a sufficiently good reason to expose the real kernel address.

Fixes: 65b584f53611 ("ref_tracker: automatically register a file in debugfs for a ref_tracker_dir")
Reported-by: Kees Cook <kees@kernel.org>
Closes: https://lore.kernel.org/netdev/202507301603.62E553F93@keescook/
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Resending since I didn't get a response from Andrew. This time I've
included netdev in the mailing list in case Jakub wants to pick this up
instead.
---
 lib/ref_tracker.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index a9e6ffcff04b1da162a5a6add6bff075c2c9405e..cce12287708ea43e9eda9fe42f82a80423cea4e3 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -434,7 +434,7 @@ void ref_tracker_dir_debugfs(struct ref_tracker_dir *dir)
 	if (dentry && !xa_is_err(dentry))
 		return;
 
-	ret = snprintf(name, sizeof(name), "%s@%px", dir->class, dir);
+	ret = snprintf(name, sizeof(name), "%s@%p", dir->class, dir);
 	name[sizeof(name) - 1] = '\0';
 
 	if (ret < sizeof(name)) {

---
base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
change-id: 20250731-reftrack-dbgfs-f99ad92068bc

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


