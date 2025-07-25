Return-Path: <netdev+bounces-209927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 611F1B1155D
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 02:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BE053B0A49
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 00:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5619D1465A5;
	Fri, 25 Jul 2025 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9sWGurZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7C2BAF4;
	Fri, 25 Jul 2025 00:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753404298; cv=none; b=CyBKv0i5HsgnVOit8CC4pWsZ6BxpHWHIlu3dr7ba/YVFvZpdFlVSPKrJAH+k9RPMxZXPguhemcrdy1xeFa4uaqGm/nyclKCZpU6RxjrtTk+i7loqOwtILVBOjR6bmULJbDM3EQA5D6/Lb7nAKH81FhOFbLYET1oI/3g2Tr5sxK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753404298; c=relaxed/simple;
	bh=0JUpLhj9MjDkorC33GFgJ/GVhIVr5NTiAIAW0RbNhsM=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=upMS/sXrZcd0NgzBjZijrUEzVWL6bOGSNx0OJOj74HA9fGAATbfAhPRSsXYIb96MQYRxlyGY4TaD4UfOTmVlF++MCQ46wijizX2pOIZMTnnaqHy957hQikO8xWebqYHPy/GwieCVCJKzO+1YbytVQ5lfBKDwkSazizcwpwyJfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9sWGurZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9855C4CEED;
	Fri, 25 Jul 2025 00:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753404298;
	bh=0JUpLhj9MjDkorC33GFgJ/GVhIVr5NTiAIAW0RbNhsM=;
	h=Date:From:To:Subject:From;
	b=D9sWGurZ5OzSdUH4R11H9EI0zhqzl98E4gwleCPHJNVB/0tnqASvghnz1Et5y2Xg7
	 pbzPI03LkdvJgIqPnx03HgymUjvo5H7483E6u0q0js4/MgnbNkkkiV57NwSm+p7VCQ
	 cvbzrUlsjR4X60H4OcA3xfyx/07C+rju1vGomDtd/l+7h6ebfb1pZUfIgyZl/WsiCM
	 iUx87Q+MX7SVIDH+FU/PRI+g5DgxYV2Chk4nIyVUpuKrNKuORwfI+TUcjqDmHcUVwz
	 Sen/4j/+D46JQeI6sRN+0sGBFNbHN/Xx2MPIr0nSTP/wm+636QxhpoaxhWKlMM6amR
	 p+OG6qEOAZJbg==
Date: Thu, 24 Jul 2025 17:44:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20250724174456.27e7ff0c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Linus is expected to cut final v6.16 this weekend, and various people
will be traveling soon, so I'd like to submit the net-next PR earlier
than usual. Tomorrow we'll go thru what's already posted, and hopefully
submit the PR on Saturday.

If you have a fix for net-next it's okay to still post it (with net-next
in the subject). net Fixes should continue to use "PATCH net".

