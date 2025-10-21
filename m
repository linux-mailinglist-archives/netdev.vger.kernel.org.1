Return-Path: <netdev+bounces-231331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D63FEBF784C
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 17:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B5334EF845
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB3D343D90;
	Tue, 21 Oct 2025 15:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHC949a0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE7A3431F6
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761062167; cv=none; b=uVBhf6LkHa9gcCxtTZiTVqgVLMpRBWVi97HImxMn7liPVQvwSVr0KXCndcoVJhlq8sGdPU8FpvjjoQjSU3wp9psmTd9DIbNHw5tQI7V4+FOHDjacbxxqhCWEglSv84mAON/5CTdxcz0QJQ+L17xORxPRQSUjyA0uBSju2lOf2HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761062167; c=relaxed/simple;
	bh=VVv99UMOrQIA+8kv7X3iJOxyhfPjHOD9vEAp6sfsC88=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Rvi59HPyUR2HBU/ZXWdBt2x7TS2HXE64HmY2wvpP4McartlTG3XnduygZtcN2bSMDakjkW9K0+dabVnSqGYv2YrMO+C4uvkY1NlS9H307bqA9/p8tYCOWgtrOCfo821OnwvUF6/o1lC/L7bv3TetZphNZmYlcXxCFwvriht5Agg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHC949a0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F52C4CEF1
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761062166;
	bh=VVv99UMOrQIA+8kv7X3iJOxyhfPjHOD9vEAp6sfsC88=;
	h=Date:From:To:Subject:From;
	b=cHC949a0EYBob9h3221vegLv7Vq8gOVbRrxwH6mDvn4sHygxHgJMus1trNcKgo5S+
	 de8aDyD1EPCH1cnKyNZ6i9jBlMvsaCKx0r7sDBd2hMBp15yubtRlJ16gqvUe7F9yXx
	 Zuu6UKLzl95gA/hWLNDGOkIkmlhzLN8ijtu4RRG6zWEfPhD4bXWSCLstXYf2d0Ffyx
	 acRVvlvnJ2AKS5jydXUTce/fg+WVxFZyQoO1FP1rFsVeDnvirBbz8gJNuQPy2AEo0k
	 ScXnSp+dlgYXflnHDTteuoSgzrfSfWACUBkvc9/hJ6G3bX7U3fsQSPmejHPsiqVncV
	 b77R48jBsEl4A==
Date: Tue, 21 Oct 2025 08:56:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev calls - Oct 21st
Message-ID: <20251021085605.7fa4ab69@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

The usual calls took place today. I didn't send an announcement earlier
because I didn't expect topics.. then I realized the PHY port repr may
need a discussion. Luckily Andrew and Maxime joined in time.

Here are the meeting notes from what transpired, and meeting notes from
netdev TSC (today's and last months).

## netdev bi-weekly

Oct 2025 (21st)
 * PHY port representation
   * No major concerns so far, just general busy-ness
   * Andrew to look after the weekend
   * We=E2=80=99ll drop from patchwork given the timelines, Andrew promises=
 to look regardless


## netdev foundation TSC

September 2025 (23rd)
Present: Paolo, Eric, Johannes, Jakub, Simon, Willem

HW lab:
 * Funding approved by the board
 * Trying to figure out the process for releasing funds
Small items:
 * Unclear how to expense
 * Google Folder has been shared by Linux Foundation
 * Waiting for resolution for Plausible, hopefully CC number will be shared
Other items:
 * #11 syzbot
   * syzbot seems to be covering netlink pretty well, needs more
     digging to find something that isn't covered
   * should we close the issue?
#7 documentation
   * is there a policy on accepting AI docs into the kernel?
#5 lore+lei
   * Jakub to reach out to Konstantin


October 2025 (21st)
Present: Paolo, Andrew, Johannes, Kuniyuki, Simon, Eric, Jakub

Plausible
 * https://plausible.io/netdev.bots.linux.dev
 * Now paid by the foundation
HW lab:
 * Order submitted for first few servers, no ETA, but maybe 1 month?
 * Johannes: we need some understanding on how access to these machines wil=
l be granted =20
AI code review
 * Chris Mason has a repo with AI prompts, trying to integrate with netdev
   https://github.com/masoncl/review-prompts/blob/main/networking.md
 * Tested on prior netdev patches, already live reviewing in BPF
 * Should we email just the author first?
 * Need a way to mark a review as known-bad
 * Need a way to teach the AI new tricks - change Chris=E2=80=99s repo?
 * Are the reviews going to show up in PW?
 * Let=E2=80=99s start with just PW then, we=E2=80=99ll think about the ML =
and sending emails later
#12, #13, #14 (tests):
 * Moving forwards with SoW, receiving quotes
 * Do we need to wait for NIPA to be up?
   * Probably not, the main use is for random drivers
 * Timeline: likely completion around Feb
LPC update:
 * Submissions under review
 * Reviewers expected to finish by end of the day tomorrow
#5 lore+lei
 * Discussion with K stalled, concerns about scalability
 * Jakub to create a more concrete proposal and share

