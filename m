Return-Path: <netdev+bounces-156321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D594FA060DA
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12D117A6621
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 15:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1319200120;
	Wed,  8 Jan 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udk7mlxh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFB8200115
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736351569; cv=none; b=LCY5zzahGTRCGhHLHLdrqUqB5tNjEmWFVKAf0arqUbupyMV61vkjl6f8DhMOAXtjtTg2jWYtdoT0TecBw8V5rE+OKQKEKWwJmwgcfIPixCj1UH3ja/nJT8cOHsiScLycxPlpTkWpCuaHvihhAZxAUCe5wdJP9RczIgclbvIZ18g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736351569; c=relaxed/simple;
	bh=JHUtmYRNc/ljqWKn9Ddi7rY3MO2joF7uF4tojHrYwHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFPMSQYnvJBHgf8RdTnwYUoZQxcAK7I/6bX7Rxi08hTusUFmSsioyN0J5ifc/nUq8z0uMb25er/3o8O/N3cKmFs4DM0erZFechRciAqyF4Tv647RfJytsBbPWPmXtj5ucpfnEYZ1RfyofMrO6Y1V+cOGh+V/5jJw+IMDUzFlhPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udk7mlxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103D4C4CED3;
	Wed,  8 Jan 2025 15:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736351569;
	bh=JHUtmYRNc/ljqWKn9Ddi7rY3MO2joF7uF4tojHrYwHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=udk7mlxhDVmgWNYa0Ivqu+Qn12Dcoio9VzVFZoNuW1VF3T+SPa2vwp1ZrGNxBWSny
	 Sv6xO8C5JebELXH4/ij4w4Sav9EyIuMndJfA83ZiPb1xQemEhFsiCph0JqZHL/AegU
	 TmwwR3oZHuIGEZGYUSkf39AYWiG6eBe4a9p3a/914MIvpw61IlObvRi6ixmeq6VJJ3
	 lmeBlpA+zKH5UbqnYouoKfwR6g+MAPzaFoukYHBisqVa2cUqpWd8lhZnCKTvDx9qNt
	 pWHRzFy5lmnsxRQ/ktmXrUhW4dJH6muTgOsRuqRPOE92wdNJCMwY9fh4FV6g2P+Z4I
	 ZlwefhtxqvNUQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen.Hegelund@microchip.com,
	lars.povlsen@microchip.com
Subject: [PATCH net v2 8/8] MAINTAINERS: remove Lars Povlsen from Microchip Sparx5 SoC
Date: Wed,  8 Jan 2025 07:52:42 -0800
Message-ID: <20250108155242.2575530-9-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108155242.2575530-1-kuba@kernel.org>
References: <20250108155242.2575530-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We have not seen emails or tags from Lars in almost 4 years.
Steen and Daniel are pretty active, but the review coverage
isn't stellar (35% of changes go in without a review tag).

Subsystem ARM/Microchip Sparx5 SoC support
  Changes 28 / 79 (35%)
  Last activity: 2024-11-24
  Lars Povlsen <lars.povlsen@microchip.com>:
  Steen Hegelund <Steen.Hegelund@microchip.com>:
    Tags 6c7c4b91aa43 2024-04-08 00:00:00 15
  Daniel Machon <daniel.machon@microchip.com>:
    Author 48ba00da2eb4 2024-04-09 00:00:00 2
    Tags f164b296638d 2024-11-24 00:00:00 6
  Top reviewers:
    [7]: horms@kernel.org
    [1]: jacob.e.keller@intel.com
    [1]: jensemil.schulzostergaard@microchip.com
    [1]: horatiu.vultur@microchip.com
  INACTIVE MAINTAINER Lars Povlsen <lars.povlsen@microchip.com>

Acked-by: Daniel Machon <daniel.machon@microchip.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: Steen.Hegelund@microchip.com
CC: lars.povlsen@microchip.com
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 694a29027b45..e7d8771f2a66 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2689,7 +2689,6 @@ N:	at91
 N:	atmel
 
 ARM/Microchip Sparx5 SoC support
-M:	Lars Povlsen <lars.povlsen@microchip.com>
 M:	Steen Hegelund <Steen.Hegelund@microchip.com>
 M:	Daniel Machon <daniel.machon@microchip.com>
 M:	UNGLinuxDriver@microchip.com
-- 
2.47.1


