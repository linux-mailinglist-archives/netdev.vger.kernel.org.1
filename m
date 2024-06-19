Return-Path: <netdev+bounces-104984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95A490F602
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDF401C213D2
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBD215887D;
	Wed, 19 Jun 2024 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NqUHyhen"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AE4158868;
	Wed, 19 Jun 2024 18:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718821472; cv=none; b=deDXjCWJ5DcOOByh5sfmtcF0x0S+YGb9vRSfnBVHmfCAMJC6r0kLy98qa/t/0pYJVRgC0Tk9DTVvNgwVBbq9WF97ty9r0x9F5HoJo3ApFLmTmd601gO4iq0bDcEV2ggCUUYcH6U/fWrPD4FYiaGCVYmoqV+NcJd5t/Hkkn0H0Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718821472; c=relaxed/simple;
	bh=0us+3ZctGfnLIyhkBA1GQ9xbHTQ48Si0bKf9MtsSuU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ihiSEe3DS5AzMyeA8ueniFkOgv9HmU+6j6Jt7UquP50AePHJ2RWy77iOpxBBGs4OBexUkgOcE1C1b9mov2hiHo5QFQem+aKOkzDX9uoHv53izI6D0tuvR8mLH6cmBKj/gbYB9Rc1SJOMNMusp8Ow0d6F7N9EGcRPj+D3w6EVTtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NqUHyhen; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB1CC4AF0F;
	Wed, 19 Jun 2024 18:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718821472;
	bh=0us+3ZctGfnLIyhkBA1GQ9xbHTQ48Si0bKf9MtsSuU4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NqUHyheni7tyuN3p18yeRrmTMS3/ltHPglwGCXPxRr8Xsi7Mf1pMKMGkPKM3X3Q0t
	 2E78GbM25d+ok4LSwRsTgafVpoNLgLsZF8WtHeM6bps18Eii9g8UJAYCto4c/dVNGP
	 4jDDdfuYjW5h3XHAQSlr0lhdVIHItIccJYhpbGeY=
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Wed, 19 Jun 2024 14:24:07 -0400
Subject: [PATCH v2 2/2] Documentation: best practices for using Link
 trailers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-docs-patch-msgid-link-v2-2-72dd272bfe37@linuxfoundation.org>
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
In-Reply-To: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
To: Jonathan Corbet <corbet@lwn.net>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
 ksummit@lists.linux.dev
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2838;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=0us+3ZctGfnLIyhkBA1GQ9xbHTQ48Si0bKf9MtsSuU4=;
 b=owGbwMvMwCW27YjM47CUmTmMp9WSGNKKlWKecivfiZ4hcSlGI0dZh6vKjVW6yebzAr7XkWl/J
 NuEHrzoKGVhEONikBVTZCnbF7spqPChh1x6jynMHFYmkCEMXJwCMJH6NIb/ldm/Z9ZJlSqaST84
 vGKH4eE/6eu0Gzb/XJlyJnHeYgOFUwx/JUNfmb+QfLnacZmZmtyX2S07pNoNSw4r13I9OJ//mLu
 UBwA=
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E

Based on multiple conversations, most recently on the ksummit mailing
list [1], add some best practices for using the Link trailer, such as:

- how to use markdown-like bracketed numbers in the commit message to
indicate the corresponding link
- when to use lore.kernel.org vs patch.msgid.link domains

Cc: ksummit@lists.linux.dev
Link: https://lore.kernel.org/20240617-arboreal-industrious-hedgehog-5b84ae@meerkat # [1]
Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
 Documentation/process/maintainer-tip.rst | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/process/maintainer-tip.rst b/Documentation/process/maintainer-tip.rst
index 64739968afa6..ba312345d030 100644
--- a/Documentation/process/maintainer-tip.rst
+++ b/Documentation/process/maintainer-tip.rst
@@ -372,17 +372,31 @@ following tag ordering scheme:
 
  - Link: ``https://link/to/information``
 
-   For referring to an email on LKML or other kernel mailing lists,
-   please use the lore.kernel.org redirector URL::
+   For referring to an email posted to the kernel mailing lists, please
+   use the lore.kernel.org redirector URL::
 
-     https://lore.kernel.org/r/email-message@id
+     Link: https://lore.kernel.org/email-message-id@here
 
-   The kernel.org redirector is considered a stable URL, unlike other email
-   archives.
+   This URL should be used when referring to relevant mailing list
+   topics, related patch sets, or other notable discussion threads.
+   A convenient way to associate ``Link:`` trailers with the commit
+   message is to use markdown-like bracketed notation, for example::
 
-   Maintainers will add a Link tag referencing the email of the patch
-   submission when they apply a patch to the tip tree. This tag is useful
-   for later reference and is also used for commit notifications.
+     A similar approach was attempted before as part of a different
+     effort [1], but the initial implementation caused too many
+     regressions [2], so it was backed out and reimplemented.
+
+     Link: https://lore.kernel.org/some-msgid@here # [1]
+     Link: https://bugzilla.example.org/bug/12345  # [2]
+
+   You can also use ``Link:`` trailers to indicate the origin of the
+   patch when applying it to your git tree. In that case, please use the
+   dedicated ``patch.msgid.link`` domain instead of ``lore.kernel.org``.
+   This practice makes it possible for automated tooling to identify
+   which link to use to retrieve the original patch submission. For
+   example::
+
+     Link: https://patch.msgid.link/patch-source-message-id@here
 
 Please do not use combined tags, e.g. ``Reported-and-tested-by``, as
 they just complicate automated extraction of tags.

-- 
2.45.2


