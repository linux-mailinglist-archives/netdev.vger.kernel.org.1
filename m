Return-Path: <netdev+bounces-104982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDAA90F5FB
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C2F3283A52
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149F3157496;
	Wed, 19 Jun 2024 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DZJ3+jX6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3C15252C;
	Wed, 19 Jun 2024 18:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718821471; cv=none; b=EXMfmgVAABytzwT/XmzbzVtY3jwVBNlHFDzPA9U6x+x9mxYaN2Pq6pyuQohjB+vsqwvM2A+yJJcjEAClBZvToh7ylXITaXaZzvb39DCtDQy2ek03jnaU+J+af6TUE6VrMy0onxR6ZqSNcZSp0zY+o44fJBJEN/U21AaIJXmUY78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718821471; c=relaxed/simple;
	bh=WXfIrwlChwS80aFk2yEGtJGX56O7hDX0YtQHgupFXUw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EYtZWayDuBDP6+p3EKrSGXQSGu8joiCBIHvnblgr18G69DYpIb47ddkMBJkdxP64dsma2PCxgZKou8NvfiOzyLePDw14oW94kjS2LAsWEsOu1/NFs60JsGuyuCwHaiNw4BfEYlHKP1T39v7pbqBJ/ciKoUIJjf3DG5A19sA4As4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DZJ3+jX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 158C8C2BBFC;
	Wed, 19 Jun 2024 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718821470;
	bh=WXfIrwlChwS80aFk2yEGtJGX56O7hDX0YtQHgupFXUw=;
	h=From:Subject:Date:To:Cc:From;
	b=DZJ3+jX6at0yY/Rs+jaFikAilrW5+FqTBzKxBZaeJiijRmymkwSKkHzrKuObx0bnk
	 aSfdpHlV7czoNlyKpfg4q6R2AFVVFy24cJHp2vKlEOj7N4URLmURca9gLlAz+tzHVa
	 Ee/WDQ7QHb9JWuPYr3H8yxgVPD7shErAzJxbhYag=
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH v2 0/2] Documentation: update information for mailing lists
Date: Wed, 19 Jun 2024 14:24:05 -0400
Message-Id: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEUic2YC/4WOTQ7CIBSEr9K8tc9AC0RdeQ/TBeGnfVGhgbapa
 bi72Au4/CaZb2aH7BK5DLdmh+RWyhRDhfbUgBl1GBySrQwtawVT/II2moyTns2I7zyQxReFJ6q
 r4kxIyZVjULtTcp62w/voK4+U55g+x8zKf+k/48qRYceklL7zUltxr/Gy+bgEq+f68hzTAH0p5
 Qu+gZy2xAAAAA==
To: Jonathan Corbet <corbet@lwn.net>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
 Dan Williams <dan.j.williams@intel.com>, ksummit@lists.linux.dev
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1864;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=WXfIrwlChwS80aFk2yEGtJGX56O7hDX0YtQHgupFXUw=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGNKKlaI3TNH+83zVqRz5rxKCi/bEHd5abfRxr/jvt1and
 wVrlUff6ChlYRDjYpAVU2Qp2xe7KajwoYdceo8pzBxWJpAhDFycAjCRZ9cZ/kfMOuo/82TJgcsT
 3p/OS9u09sKBDzsSP2+MyZt1tP3Zi+WTGBkaM6+Fce3srWcK38OZ88poufjEu+7mL0/OFJQVDpy
 +PI0fAA==
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E

There have been some important changes to the mailing lists hosted at
kernel.org, most importantly that vger.kernel.org was migrated from
majordomo+zmailer to mlmmj and is now being served from the unified
mailing list platform called "subspace" [1].

This series updates many links pointing at obsolete locations, but also
makes the following changes:

- drops the recommendation to use /r/ subpaths in lore.kernel.org links
(it has been unnecessary for a number of years)
- adds some detail on how to reference specific Link trailers from
inside the commit message

Some of these changes are the result of discussions on the ksummit
mailing list [2].

Link: https://subspace.kernel.org # [1]
Link: https://lore.kernel.org/20240617-arboreal-industrious-hedgehog-5b84ae@meerkat/ # [2]
Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
Changes in v2:
- Minor wording changes to text and commit messages based on feedback.
- Link to v1: https://lore.kernel.org/r/20240618-docs-patch-msgid-link-v1-0-30555f3f5ad4@linuxfoundation.org

---
Konstantin Ryabitsev (2):
      Documentation: fix links to mailing list services
      Documentation: best practices for using Link trailers

 Documentation/process/2.Process.rst          |  8 ++++----
 Documentation/process/howto.rst              | 10 +++++-----
 Documentation/process/kernel-docs.rst        |  5 ++---
 Documentation/process/maintainer-netdev.rst  |  5 ++---
 Documentation/process/maintainer-tip.rst     | 30 ++++++++++++++++++++--------
 Documentation/process/submitting-patches.rst | 15 +++++---------
 6 files changed, 40 insertions(+), 33 deletions(-)
---
base-commit: 6ba59ff4227927d3a8530fc2973b80e94b54d58f
change-id: 20240618-docs-patch-msgid-link-6961045516e0

Best regards,
-- 
Konstantin Ryabitsev <konstantin@linuxfoundation.org>


