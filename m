Return-Path: <netdev+bounces-100849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EB58FC450
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 961701F26C8D
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FCC18C33F;
	Wed,  5 Jun 2024 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHXojvJF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E67619148A;
	Wed,  5 Jun 2024 07:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571775; cv=none; b=AfELpcC5le71iCkl/zyr26ys0WvQ4YO+723n2E+smsSubpurS6lKzyFFcpVQk8xZFcGB8kb+5oOn8GuPLjzxDBeYksqGYmxyTCIUaqrJYuWhS6z7nlRdN7W8vNu7QPtEnOxVZvDWXvh1pXD02zoCa2x6uxOwNOvjHa4fCLNEuhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571775; c=relaxed/simple;
	bh=ej8v0/75YvFLQkYynFarXRgl/ZzJFpTxeBDUabEwZzM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OeHAFntMnq1MRQERN276JbOPkFftW+D4ownchITo7nrXoRAG1bM7RE4p8sovvrB0lxfuyigz+Q6GxUFculQ6vHpLOJx83JlmWLvV6TubxjO/+ZJbRwBFmZwLUheQwZbdSvJkmH/eMXF8phYkXQ7KtuHlyg9IqVUFANHAQ6gFSys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHXojvJF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE72C3277B;
	Wed,  5 Jun 2024 07:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717571774;
	bh=ej8v0/75YvFLQkYynFarXRgl/ZzJFpTxeBDUabEwZzM=;
	h=From:Subject:Date:To:Cc:From;
	b=sHXojvJFueOpYA7pqNWbErqcw7UPxoVixwaVF3YSLX6K36eiZpYkVD4dYLzty8ic6
	 qpCHT5aOSxhZPZWexNWNiVp3rSD8fOdb4L8phiuhYJPPcDFQ/BEj1Sm/HJAwdxgIc6
	 lFfc4YYnXBRNIK0Q7KUs4U36jqap77Em+y61cMrHGaEbmdbIQ3EoSvZtIG4FEIYhq8
	 BBFzKrNY2HLRIff7tOjfIxcAcgEzfmW8GdtFET3p+poZyMQ4C6NZBzQlHHdyIewROy
	 OwOUefuMuumXaXit3hjW4CzbEir9DNZ4FH8cGACDboLshpTrqshUXwAfSBSnifKO0Z
	 gLXXng/Ud7ZHQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH net-next 0/3] mptcp: misc. cleanups
Date: Wed, 05 Jun 2024 09:15:39 +0200
Message-Id: <20240605-upstream-net-next-20240604-misc-cleanup-v1-0-ae2e35c3ecc5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJsQYGYC/z2NwQqDMBBEf0X27EKMptL+ingIcW0XahqyiQjiv
 xsEe5jDY3gzOwhFJoFXtUOklYV/vkBTV+A+1r8JeSoMWulOPVSHOUiKZBf0lEq2hP9qYXHovmR
 9Dtj3U6tN+3TGzFDWQqSZt+tpgNuF8ThOOh9DJ4MAAAA=
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>, Davide Caratti <dcaratti@redhat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=909; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=ej8v0/75YvFLQkYynFarXRgl/ZzJFpTxeBDUabEwZzM=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYBC6giU7OqsLP9SRwngKz2nv8EwB1jWpW1LWI
 UyWeEluJi2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmAQugAKCRD2t4JPQmmg
 c5r3D/956rKFPfpm81mshDeIjhsjILlIJ+4T7jRszasXEwrmD1FFfM9zzRsHuLuhaGEKIqJGnZq
 qUt+2FwXyKXJlOWHcXOiQGczmHFfiSuSTk6QldvdZSqYziGVdqk7BgLboLDgf61Ncx5WE5K/hyf
 u9+3yVvgYlQMnNa+a8xhMwRHIy9cbhESkcDOdEbOfTPgc+/4g7ibMCeO9EdQiY9Fp82O3EU/DiQ
 +NrXgChZGwQgjPoiIuOcHNiw9TeWFJ9E1gVQyKKxLEgiVWkJokTrQWTo2eGLz0Lrni6nhrLpoUg
 Mt2hknqe+UdbXKvG6DuJfwNGc8apwZ7Oev5ZRmvAbmPqjCWze7X08+WYf6b7R/QJC0jx/QhAhYQ
 aOJighLrS/f+I8kBimeKb9ovX+ZGwxyX9lA3wZR3CAM9WV9583Kx1qqne6SErBkteYzQkEIFU0G
 bItoGG6aKBNHerCzESGOCEqLJmr4+SoYgi+rU+kIRG8cFN9CYv5qndTezY5OfwOqewKJiPvqkwW
 pqUebbmdEG7Sxte2aVC6f37RRP9Ky12kADxcoVcKHR5py9CtjbBtNZS5XMYFtTdoeukSdpV+53c
 85Yv7G35rLLKlD4xonMQuuzMNAdA4Bn3nYmsQivRnhxLNPallUY5epqiJ/uVYhB5E6VEZv0jWXj
 gf8NDtpwtOdIRJQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

Here is a small collection of miscellaneous cleanups:

- Patch 1 uses an MPTCP helper, instead of a TCP one, to do the same
  thing.

- Patch 2 adds a similar MPTCP helper, instead of using a TCP one
  directly.

- Patch 3 uses more appropriated terms in comments.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
Davide Caratti (1):
      mptcp: refer to 'MPTCP' socket in comments

Geliang Tang (2):
      mptcp: use mptcp_win_from_space helper
      mptcp: add mptcp_space_from_win helper

 net/mptcp/protocol.c | 8 ++++----
 net/mptcp/protocol.h | 5 +++++
 net/mptcp/sockopt.c  | 2 +-
 net/mptcp/subflow.c  | 2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)
---
base-commit: a6ba5125f10bd7307e775e585ad21a8f7eda1b59
change-id: 20240604-upstream-net-next-20240604-misc-cleanup-77d32539c55f

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


