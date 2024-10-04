Return-Path: <netdev+bounces-131941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DDE990034
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E8711F24985
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 09:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF89414600F;
	Fri,  4 Oct 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOZk/s0H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BE133FD;
	Fri,  4 Oct 2024 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035404; cv=none; b=q7J4mHMzt+3IfqoPJ9msVMWxenwsDWFyG5UlgIFV3QmXSNGxxDv0wpr2GgdVzV7mmYCFKJnQ40qkNE7fa42Uop5htF1wK9uVBzCQL1SehLZJsKS6vv2HIHxM86mZnJlpDm7p4kQfzVwRlHK0CcPtSc6AbU5NUwqPS655yaiuxME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035404; c=relaxed/simple;
	bh=tOhmMjwayNEBMiL47J3oxGjcYEC7q9iL7ikaYSfQkoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sSPrErI9a+OwAKeTo9MnQOAeuKkQIz18THi4keZV/jJHtyTYL4Tvz4gB56nrLlIq35hGayuy15TcG+WKPDFJFFWwpW/CM8p+RWk+QIEtIm8qhwB46UKbkEGc75yDphXRR6N6YUemqS7HUIonW8R+Tz2j+tlN3XXcJQj+7wt996Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOZk/s0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60D9C4CEC6;
	Fri,  4 Oct 2024 09:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728035404;
	bh=tOhmMjwayNEBMiL47J3oxGjcYEC7q9iL7ikaYSfQkoY=;
	h=From:Date:Subject:To:Cc:From;
	b=qOZk/s0HEG2q08N8F8/iQX3Syz/XzJHJVQtZLi1ePeiwovEhQwyFs/B2R32Z0PyBg
	 dsHNEplp3MYwdrrt+TBxC2qPOTc8NoK9kW2r4cRIQiIjyeX/hp3mDIyhzfoKNJy28r
	 Wnhe9Wh6v8dQHvRLT+j9kSARSHeU+vNM7+w40ul+fMpkuUkSEEldzWjMoNv/dJwR3T
	 TuC1AoOv5z+MwQQrq6w5K3GTwIZgsHmYIcw7s9aoDkEmcszijg/A9aoe3Rmr/q/wBy
	 WDj0SZt8QUD9lPyQNnVPaN1xWoXZ3cS+Ehj+o2b3hR0yvXVBdAGxjVkcsAhXr4D2Qr
	 8GALyH2TJ132w==
From: Simon Horman <horms@kernel.org>
Date: Fri, 04 Oct 2024 10:49:53 +0100
Subject: [PATCH RFC net] docs: netdev: document guidance on cleanup patches
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241004-doc-mc-clean-v1-1-20c28dcb0d52@kernel.org>
X-B4-Tracking: v=1; b=H4sIAEC6/2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwMT3ZT8ZN3cZN3knNTEPN1U00QTYwNTs5RUo1QloJaCotS0zAqwcdF
 KQW7OCnmpJUqxtbUAUmzcnmcAAAA=
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.14.0

The purpose of this section is to document what is the current practice
regarding clean-up patches which address checkpatch warnings and similar
problems. I feel there is a value in having this documented so others
can easily refer to it.

Clearly this topic is subjective. And to some extent the current
practice discourages a wider range of patches than is described here.
But I feel it is best to start somewhere, with the most well established
part of the current practice.

--
I did think this was already documented. And perhaps it is.
But I was unable to find it after a quick search.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 Documentation/process/maintainer-netdev.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index c9edf9e7362d..da9980ad0c57 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -355,6 +355,8 @@ just do it. As a result, a sequence of smaller series gets merged quicker and
 with better review coverage. Re-posting large series also increases the mailing
 list traffic.
 
+.. _rcs:
+
 Local variable ordering ("reverse xmas tree", "RCS")
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -391,6 +393,15 @@ APIs and helpers, especially scoped iterators. However, direct use of
 ``__free()`` within networking core and drivers is discouraged.
 Similar guidance applies to declaring variables mid-function.
 
+Clean-Up Patches
+~~~~~~~~~~~~~~~~
+
+Netdev discourages patches which perform simple clean-ups, which are not in
+the context of other work. For example addressing ``checkpatch.pl``
+warnings, or :ref:`local variable ordering<rcs>` issues. This is because it
+is felt that the churn that such changes produce comes at a greater cost
+than the value of such clean-ups.
+
 Resending after review
 ~~~~~~~~~~~~~~~~~~~~~~
 


