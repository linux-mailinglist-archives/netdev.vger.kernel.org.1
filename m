Return-Path: <netdev+bounces-86670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11AA289FC94
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 18:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0EAF284B9B
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586B917557B;
	Wed, 10 Apr 2024 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EyqZZ3xb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3338815F3F1;
	Wed, 10 Apr 2024 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765577; cv=none; b=QzD6CqDjxqB6Bxfo56kzi8NgBKEoMECCiVhdacuCIjFmLunDH7w0t8kG2YOhb4YPKoiT/dnXcsehtXyFEU3zZmf3iPcz4TPP8mj+b94dh0KFVv9Oim7YIZpC0rH+tnSXsDvoMRQUKBhYHntwAHj9jSEAyt9/M1Pliyecu8ccoos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765577; c=relaxed/simple;
	bh=EhCB2XIjwb/Dmg8c4ar9v+ED/YxkdMDO2KVGfgDISpk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=XZ/bKOEH3QDZeFj6Gi++FVVXkVZi26zvotzqcVmNVKljFsnqb8R4xP4jbFRAKLZ31YuBX6RuAWOtpjI/A4lEAIkJGhmjX4jH1tyXNje5Z/87D62gyhpN+yqCX0g1Dnc74YNqVHDPXk5InzG/OIgS/tlUuqtO1qoCBZL8/sWYrAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EyqZZ3xb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A031DC433F1;
	Wed, 10 Apr 2024 16:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712765576;
	bh=EhCB2XIjwb/Dmg8c4ar9v+ED/YxkdMDO2KVGfgDISpk=;
	h=Date:From:To:Subject:From;
	b=EyqZZ3xbtkwaDSLNdCieb8o3GpE+lZOHIXv54wStdL8Pq9i1QJKxslIHxco846NuF
	 unwTwEgqjo/BBwq02RRuTN3vJiCPoKiO8BdUmCnreTU0xbtjl6gRnL1/r27Pk2KMXh
	 EbJ1b69XhM/YPm6UFTZoh+qfKGkXE5njyMSQ83KaReskjZngy5PRkLERiQpP8xUJeT
	 kikfzYRBvvVczVnJnYOlTb610xi97f+im3PA3HPtuYsw4ra2FJnAa40t0nPJLH+Zur
	 F/t3nUntEersdl7UhD3m0qvmNwvCj47CrxxkYxtL0djuKHX6L58DEMHRF51Utd6ve8
	 8z3yJZOK6Yd0w==
Date: Wed, 10 Apr 2024 09:12:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netconf 2024 open for submissions
Message-ID: <20240410091255.2fd6a373@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

As many of you know we try to organize a small gathering of maintainers
and (subset of) key contributors each year, and call it netconf (not to
be confused with the larger netdev.conf). If everything goes according
to plan, this year=E2=80=99s netconf will be held during LPC in Vienna.
Netconf used to be by-invitation-only but we=E2=80=99d like to experiment w=
ith
opening up the conference a little bit. We have already hand-picked
a number of people, but there=E2=80=99s a number of =E2=80=9Cseats=E2=80=9D=
 left. If you have
made or are planning to make interesting contributions to the
networking stack in the next 6 months, or have a use case/problem
of major interest to discuss - please contact the maintainers and
describe the topic. Descriptions can be as short as a few sentences.

Keep in mind that the conference is discussion oriented.

We want to keep a hard limit of 20 attendees, so please expect the
selection process to appear arbitrary. The selection process will
account for many factors, importance and technical quality of
the work is just a part of it. Nonetheless shoot your shot, please!

The submission deadline is 2 months before the conference - July 16th.

 - netdev maintainers

