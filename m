Return-Path: <netdev+bounces-97158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010078C99AE
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 10:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7681C211C0
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 08:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2A91BC23;
	Mon, 20 May 2024 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd/rE/3v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE5CE554;
	Mon, 20 May 2024 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193026; cv=none; b=f6K+LpuBSccMOlxnMUBvRSVS4gwGiIYBY7irJtoxLe06AHiSIk7JzY0yyL/S/VVGmh5Sj/SBx/+1UXLEl2Nioy6RsKf73HF55CeXJaDALg/7ZCEq5a7LN4kcILjCZxLUaZF3ifQSq7xvVvBdsvaFMrT5bnxF/D2TZiqXJsJ9Ic0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193026; c=relaxed/simple;
	bh=kC+d8Eaw9kodIS1Eil070H+nDygrxbdBOm02pE9boGA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XlwR0d7/P7i+I38RUFr47i5xxBKyQB/MJImw3gjGc+slXHxD/LIkBViU2dsp3zbtSY3Tvp7PPwlbg7t3rsiRe8xOV+ZWjt54to2AKXkMU+g2q2D+a+MqOv89IBgbIpC82OfQ2PLEWlICK47zuTBnQoczaI5SK+HuXJi0j982FDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dd/rE/3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61B1C2BD10;
	Mon, 20 May 2024 08:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716193025;
	bh=kC+d8Eaw9kodIS1Eil070H+nDygrxbdBOm02pE9boGA=;
	h=From:Subject:Date:To:Cc:From;
	b=Dd/rE/3vfvnNvgm4jqnquecuI0lLlhp6XTXYgZRrD8kEy3TPSttDY+vXCbjcAfanl
	 s7ePrWNapHb2RMZIiy7JRIz2FG4fbmNA0FHG2SY3ekjAVDicSzMGs2jOILqKIafc6Z
	 UauUq0wEQnwwT5RbXYs10zTO+i1vJLEShjm9XYz3brVPguuhAn9jX1fwcehbAphBDe
	 x/uVwYYg+WR9V4E95TPtbhVAphOcIwbv9Vnrb62GKK6i6inN5qYPenUpX3WygV4DM4
	 +inpC/lnkVMH7ADm4WErJgqAbAUxDb4Yrd4pP0HpUBph5JSJfI0Bu59X+6BFp3Pdz/
	 iH5HwboNPnYyw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net 0/3] doc: mptcp: new general doc and fixes
Date: Mon, 20 May 2024 10:16:39 +0200
Message-Id: <20240520-upstream-net-20240520-mptcp-doc-v1-0-e3ad294382cb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOcGS2YC/z2NQQqDMBBFryKzdiCOSqFXkS7C+G1nYQxJKgXx7
 g0uXL4P77+DMpIh07M5KGG3bFuo0LUN6ceHN9jmyiROBjeK42/MJcGvHFD4XtdYNPK8KWN8eO1
 FMHil+hITFvtdhYmqQ6/z/AN75srjdgAAAA==
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Gregory Detal <gregory.detal@gmail.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1262; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=kC+d8Eaw9kodIS1Eil070H+nDygrxbdBOm02pE9boGA=;
 b=kA0DAAgB9reCT0JpoHMByyZiAGZLBv2jod6cd9tvMvkwvroD6mP6HHY6GUB18jxjO71RxM/aY
 YkCMwQAAQgAHRYhBOjLhfdodwV6bif3eva3gk9CaaBzBQJmSwb9AAoJEPa3gk9CaaBzOFYP/0vm
 WDAQ9BgTjAGaolMs2FiBrCSi6fbRhQCg1z2j0YBx+8nO3ZhLKsGr3Ygf2h5p0Bmbr1qRDaa+C2O
 lj4kK8vmzGxomoBmQsOIAMFMzDr1jJf1xWt8PnTLykNQOgwcVkAiVtuWkB6JhK+Rgx4ydFSIjY8
 PO3fHSyhZhtqGE0aaXPgb8KbmBXU9qylnQPyQYUsrwtfvMPZ8v3ccgkxhSCyc/UkeugE/xk8zpX
 9Ks4qAzpGEZ/gPLM2X2dDCJsxdv+O7i8MXe2L3Z5y2o6AOmoltYXssjmffRhva8NIhUKXR0HL1T
 nbH0ZFBnYY7xmQpLiLBoaatl3ZViGeUyZpG8PidaTMyrBhHjHDgCGRYO91FFLBZjALVtoD/3hZX
 d5p00Xm+4J9go6Zgf1OsPjmQ+SwFvzG9c5WTc/GJdJbSjqDcK32B4X8MbhaAcR9uvJQPoec3VOs
 +Gj1UU+XPLIxUn3kMzQb3N7RQTVUMoM/ho6TF/aHP0Dr+2AADEJ4sTqhBM7ryVksHt0kE2hKfZY
 WbYC8zPj20xZ2xQPQ2MGDwWZsOOdjW5LxbSjD38L8MHORU6X2DcXJI3sX0IivNfR1HculLWsYq/
 uILbohHC7oqJ9bzKbymEeuXaGl6PiD9+sJf2eyenNWYku41nmJYFyAPSuuLAo4kL04W/FO3yKDw
 w08y+
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

A general documentation about MPTCP was missing since its introduction
in v5.6. The last patch adds a new 'mptcp' page in the 'networking'
documentation.

The first patch is a fix for a missing sysctl entry introduced in v6.10
rc0, and the second one reorder the sysctl entries.

These patches can be applied without conflicts on top of the 'net' tree
and the 'docs-next' one. They are currently based on top of the current
'net' tree because the first patch is a fix for a patch that is not in
'docs-next' yet.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Matthieu Baerts (NGI0) (3):
      doc: mptcp: add missing 'available_schedulers' entry
      doc: mptcp: alphabetical order
      doc: new 'mptcp' page in 'networking'

 Documentation/networking/index.rst        |   1 +
 Documentation/networking/mptcp-sysctl.rst |  74 +++++++-------
 Documentation/networking/mptcp.rst        | 156 ++++++++++++++++++++++++++++++
 MAINTAINERS                               |   2 +-
 4 files changed, 197 insertions(+), 36 deletions(-)
---
base-commit: 4b377b4868ef17b040065bd468668c707d2477a5
change-id: 20240520-upstream-net-20240520-mptcp-doc-e57ac322e4ac

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


