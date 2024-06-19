Return-Path: <netdev+bounces-104983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B28C190F5FF
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D70B1F22E9E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D541581FC;
	Wed, 19 Jun 2024 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0OJiTwTC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D069157E99;
	Wed, 19 Jun 2024 18:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718821471; cv=none; b=VYgi1U+MEieoJEp8fdYuNIdj2NKeVs5tzPSbW4DocGOI+3EVU+ig9OnSwhbHDpQCnwCHSXtZikXoW9560F0hivSTLAVergxgvcrLzllU68Uj2cMqCs5qrjINOverHCS/l+Vb3ICbetN/sW37JT9N33rKoc1Y+ZfCGlEasbxThA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718821471; c=relaxed/simple;
	bh=P5y5TG20YSipXqSJpzYAIqo8XcT0CbwONHrOU9B+bS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBiAMpJ+nIJdkAe06di23T4FZgd0cOMVqFsItkV/MPht0SqQCoL8syyxUOQbG2VH8KZUqDzKPs+4mgQ21XZL6Sk7eWWFfEU7uuK8WywL5oFgEIZhEzY0AOim+VcX8aFHtopzTd/2pr5LaXwslNaRjCSTvdXVZNOFOxIQjAmsTIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0OJiTwTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4672DC4AF08;
	Wed, 19 Jun 2024 18:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718821471;
	bh=P5y5TG20YSipXqSJpzYAIqo8XcT0CbwONHrOU9B+bS8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=0OJiTwTCBkzEWYElqjdFd4UDh5uPDYLRwHIAL6Z7JJRaAU1ddgvmdJ7NXKufXexFH
	 Ekd5LMjtkeDjA4Yp7ff5f66uR6jBEDcRtSuD2sFWWf1cJHE3LuxL1j0093/FVEGLWB
	 AxkmnOo1ekfRkbmK1ReEskv709AvtOQvKdDG8or0=
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Date: Wed, 19 Jun 2024 14:24:06 -0400
Subject: [PATCH v2 1/2] Documentation: fix links to mailing list services
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-docs-patch-msgid-link-v2-1-72dd272bfe37@linuxfoundation.org>
References: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
In-Reply-To: <20240619-docs-patch-msgid-link-v2-0-72dd272bfe37@linuxfoundation.org>
To: Jonathan Corbet <corbet@lwn.net>, 
 Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
 Dan Williams <dan.j.williams@intel.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7758;
 i=konstantin@linuxfoundation.org; h=from:subject:message-id;
 bh=P5y5TG20YSipXqSJpzYAIqo8XcT0CbwONHrOU9B+bS8=;
 b=kA0DAAoWtsQc41ZkmWwByyZiAGZzIluiB3CUTq72ceuNxT8C64n3FRr1PIZrIRQWtXAAh9MOU
 oh1BAAWCgAdFiEEdr5dslJx4UgeZ4w1tsQc41ZkmWwFAmZzIlsACgkQtsQc41ZkmWxavwD7Bcsk
 8v1FkjDMW3xIqlyTs3t3gwcJlzJgOWaKTNB1R/IA/0z3gEn4pbd/I1+SH8gGbtKDoK4WU0btkS1
 0cTnRE7MC
X-Developer-Key: i=konstantin@linuxfoundation.org; a=openpgp;
 fpr=DE0E66E32F1FDD0902666B96E63EDCA9329DD07E

There have been some changes to the way mailing lists are hosted at
kernel.org. This patch does the following:

1. fixes links that are pointing at the outdated resources
2. removes an outdated patchbomb admonition

We still don't particularly want or welcome huge patchbombs, but they
are less likely to overload our systems.

Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
---
 Documentation/process/2.Process.rst          |  8 ++++----
 Documentation/process/howto.rst              | 10 +++++-----
 Documentation/process/kernel-docs.rst        |  5 ++---
 Documentation/process/maintainer-netdev.rst  |  5 ++---
 Documentation/process/submitting-patches.rst | 15 +++++----------
 5 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
index 613a01da4717..ef3b116492df 100644
--- a/Documentation/process/2.Process.rst
+++ b/Documentation/process/2.Process.rst
@@ -392,13 +392,13 @@ represent a potential hazard to developers, who risk getting buried under a
 load of electronic mail, running afoul of the conventions used on the Linux
 lists, or both.
 
-Most kernel mailing lists are run on vger.kernel.org; the master list can
+Most kernel mailing lists are hosted at kernel.org; the master list can
 be found at:
 
-	http://vger.kernel.org/vger-lists.html
+	https://subspace.kernel.org
 
-There are lists hosted elsewhere, though; a number of them are at
-redhat.com/mailman/listinfo.
+There are lists hosted elsewhere; please check the MAINTAINERS file for
+the list relevant for any particular subsystem.
 
 The core mailing list for kernel development is, of course, linux-kernel.
 This list is an intimidating place to be; volume can reach 500 messages per
diff --git a/Documentation/process/howto.rst b/Documentation/process/howto.rst
index eebda4910a88..9438e03d6f50 100644
--- a/Documentation/process/howto.rst
+++ b/Documentation/process/howto.rst
@@ -331,7 +331,7 @@ they need to be integration-tested.  For this purpose, a special
 testing repository exists into which virtually all subsystem trees are
 pulled on an almost daily basis:
 
-	https://git.kernel.org/?p=linux/kernel/git/next/linux-next.git
+	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
 
 This way, the linux-next gives a summary outlook onto what will be
 expected to go into the mainline kernel at the next merge period.
@@ -373,12 +373,12 @@ As some of the above documents describe, the majority of the core kernel
 developers participate on the Linux Kernel Mailing list.  Details on how
 to subscribe and unsubscribe from the list can be found at:
 
-	http://vger.kernel.org/vger-lists.html#linux-kernel
+	https://subspace.kernel.org/subscribing.html
 
 There are archives of the mailing list on the web in many different
 places.  Use a search engine to find these archives.  For example:
 
-	https://lore.kernel.org/lkml/
+	https://lore.kernel.org/linux-kernel/
 
 It is highly recommended that you search the archives about the topic
 you want to bring up, before you post it to the list. A lot of things
@@ -393,13 +393,13 @@ groups.
 Many of the lists are hosted on kernel.org. Information on them can be
 found at:
 
-	http://vger.kernel.org/vger-lists.html
+	https://subspace.kernel.org
 
 Please remember to follow good behavioral habits when using the lists.
 Though a bit cheesy, the following URL has some simple guidelines for
 interacting with the list (or any list):
 
-	http://www.albion.com/netiquette/
+	https://subspace.kernel.org/etiquette.html
 
 If multiple people respond to your mail, the CC: list of recipients may
 get pretty large. Don't remove anybody from the CC: list without a good
diff --git a/Documentation/process/kernel-docs.rst b/Documentation/process/kernel-docs.rst
index 8660493b91d0..3476fb854c7a 100644
--- a/Documentation/process/kernel-docs.rst
+++ b/Documentation/process/kernel-docs.rst
@@ -194,9 +194,8 @@ Miscellaneous
 
     * Name: **linux-kernel mailing list archives and search engines**
 
-      :URL: http://vger.kernel.org/vger-lists.html
-      :URL: http://www.uwsg.indiana.edu/hypermail/linux/kernel/index.html
-      :URL: http://groups.google.com/group/mlist.linux.kernel
+      :URL: https://subspace.kernel.org
+      :URL: https://lore.kernel.org
       :Keywords: linux-kernel, archives, search.
       :Description: Some of the linux-kernel mailing list archivers. If
         you have a better/another one, please let me know.
diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 5e1fcfad1c4c..fe8616397d63 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -25,9 +25,8 @@ drivers/net (i.e. hardware specific drivers) in the Linux source tree.
 Note that some subsystems (e.g. wireless drivers) which have a high
 volume of traffic have their own specific mailing lists and trees.
 
-The netdev list is managed (like many other Linux mailing lists) through
-VGER (http://vger.kernel.org/) with archives available at
-https://lore.kernel.org/netdev/
+Like many other Linux mailing lists, the netdev list is hosted at
+kernel.org with archives available at https://lore.kernel.org/netdev/.
 
 Aside from subsystems like those mentioned above, all network-related
 Linux development (i.e. RFC, review, comments, etc.) takes place on
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 66029999b587..f310f2f36666 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -119,10 +119,10 @@ web, point to it.
 
 When linking to mailing list archives, preferably use the lore.kernel.org
 message archiver service. To create the link URL, use the contents of the
-``Message-Id`` header of the message without the surrounding angle brackets.
+``Message-ID`` header of the message without the surrounding angle brackets.
 For example::
 
-    Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
+    Link: https://lore.kernel.org/30th.anniversary.repost@klaava.Helsinki.FI
 
 Please check the link to make sure that it is actually working and points
 to the relevant message.
@@ -243,11 +243,9 @@ linux-kernel@vger.kernel.org should be used by default for all patches, but the
 volume on that list has caused a number of developers to tune it out.  Please
 do not spam unrelated lists and unrelated people, though.
 
-Many kernel-related lists are hosted on vger.kernel.org; you can find a
-list of them at http://vger.kernel.org/vger-lists.html.  There are
-kernel-related lists hosted elsewhere as well, though.
-
-Do not send more than 15 patches at once to the vger mailing lists!!!
+Many kernel-related lists are hosted at kernel.org; you can find a list
+of them at https://subspace.kernel.org.  There are kernel-related lists
+hosted elsewhere as well, though.
 
 Linus Torvalds is the final arbiter of all changes accepted into the
 Linux kernel.  His e-mail address is <torvalds@linux-foundation.org>.
@@ -866,9 +864,6 @@ Greg Kroah-Hartman, "How to piss off a kernel subsystem maintainer".
 
   <http://www.kroah.com/log/linux/maintainer-06.html>
 
-NO!!!! No more huge patch bombs to linux-kernel@vger.kernel.org people!
-  <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
-
 Kernel Documentation/process/coding-style.rst
 
 Linus Torvalds's mail on the canonical patch format:

-- 
2.45.2


