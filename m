Return-Path: <netdev+bounces-145544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB9FD9CFC73
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 04:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33CEEB27315
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 03:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E2F44C94;
	Sat, 16 Nov 2024 03:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="QibyHDmv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9128FF
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 03:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731726519; cv=none; b=LHfWRnBvc0iWorvrzhJAhcVsJLs8q0/Ia7BDXcsmHeWVxN0jqWNgAM0UQHELNig2+i9vrs6nu8Tx0ekNlNZSbj/xm9f94PQTVt4kDPbPmJZOYTi1VC7be7ZtqZvxYAHsTRSzo0oLHBvDrV01xpMWU740MXBQxtOE+jn35H44lAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731726519; c=relaxed/simple;
	bh=1U0vIlKdjNdwq0uIGISv0beR2ytZhN47NmtCmMjgKuE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QMOMgRj8jlf9WgveTY+iZ+jdjsU1kiBUAhl+ZkA5QlDPJQwh+MiEWdNBimxtQAaBMeRx7WOUW6CodkIqHRztc3bi2r8nccXO5hrEVbko01gTA8QQ03ua8YKnTJw80nPTYaWg5/dbLa7DwCCEgrC0913tYICLxrWUBBu9emJd57U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=QibyHDmv; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id C9AdtOwuv8AEMC9AltID1G; Sat, 16 Nov 2024 04:08:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1731726513;
	bh=LlCRrRHfAW5mifLwe3cUTm3WW0qOLwqUBxTpRxUBGvs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=QibyHDmveo32U+LPmRGav/4GOR6befplbkhI3BzDITysNDfkJnuewcmFdSc9H0A3A
	 NPm000qTjp3tCgAMYwWofKXSGOzshwNyiz2TyrX9+kvy97u4bYeU3gPWo0QwrZII6L
	 OdJxvcrN+iI9gZrilvYSWBhtpiJBJKDkqZrazzaF0v2d/tmhp7CxjE+FC2vb0CVVtw
	 eoonCIEJbqsUerO5IJ4qU5U0dz5W4f9s3bk4FwUrufwo4AwAskkBkV5naCxvPGX3xR
	 EM/R55/TbviWNbUDI6uRGSWluphwY4tAARcrOfBVx5mHEKZCg0APF668BnkNssnUrU
	 2yj06D+g8MFxA==
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 16 Nov 2024 04:08:33 +0100
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH iproute2-next v2] add .editorconfig file for basic formatting
Date: Sat, 16 Nov 2024 12:05:43 +0900
Message-ID: <20241116030802.1267075-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2303; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=1U0vIlKdjNdwq0uIGISv0beR2ytZhN47NmtCmMjgKuE=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkWPJP+6TBPEJzy/b6g/tvJDs1CC9s2i27h3dMq2H18U 84cocItHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACYiF8TIMOWT6HcHZonHKz58 vvOuftKh7ULdafFHGGSs/1oUzZ825TYjw5t34UI7PPI/q7eVfUuZO+3mkfezNt7kW+Eg2b6257R hFDMA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

EditorConfig is a specification to define the most basic code formatting
stuff, and it is supported by many editors and IDEs, either directly or via
plugins, including VSCode/VSCodium, Vim, emacs and more.

It allows to define formatting style related to indentation, charset, end
of lines and trailing whitespaces. It also allows to apply different
formats for different files based on wildcards, so for example it is
possible to apply different configurations to *.{c,h}, *.json or *.yaml.

In linux related projects, defining a .editorconfig might help people that
work on different projects with different indentation styles, so they
cannot define a global style. Now they will directly see the correct
indentation on every fresh clone of the project.

Add the .editorconfig file at the root of the iproute2 project with a broad
generic configuration for all file types. Then add exceptions for the file
types which follow different conventions.

See https://editorconfig.org

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
For reference, here is the .editorconfig of the kernel:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/.editorconfig

** Changelog **

v1 -> v2

  - remove *.yaml configuration as there are no such files in the
    iproute2 project.

  - factorize common configurations under the default [*] category.

  - add back the trim_trailing_whitespace option.

  - add back the max_line_length option: 100 columns per default, 75
    columns for commit messages and patches.

Link: https://lore.kernel.org/netdev/20241115151030.1198371-2-mailhol.vincent@wanadoo.fr/
---
 .editorconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 .editorconfig

diff --git a/.editorconfig b/.editorconfig
new file mode 100644
index 00000000..97e961b9
--- /dev/null
+++ b/.editorconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+
+root = true
+
+[*]
+charset = utf-8
+end_of_line = lf
+indent_size = 8
+indent_style = tab
+insert_final_newline = true
+max_line_length = 100
+tab_width = 8
+trim_trailing_whitespace = true
+
+[*.json]
+indent_style = space
+indent_size = 4
+
+[{COMMIT_EDITMSG,*.patch}]
+max_line_length = 75
--
2.45.2

