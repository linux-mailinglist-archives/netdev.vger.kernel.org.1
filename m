Return-Path: <netdev+bounces-216588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE39B34A01
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F1D1677B5
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD913112A4;
	Mon, 25 Aug 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utHQFRF3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CA230E821;
	Mon, 25 Aug 2025 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145695; cv=none; b=cBhp7Nj/sXGwJGi2ZoLu40BqirXW5HtLwD+8jdo81d51Jvk3U1fqcNh/ui+2VXA8qf4NXtsal7bJ8J+412bdScrx/f60UfYoe44Ug6xkV7xWijKGEX/66JB2hCyqTPx+TmEL02sDsEicP2hEctHMuEgI8w8jAPX4K1v9RDfKMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145695; c=relaxed/simple;
	bh=J1MwtVp5jXRKRwKBsk/a5nbUIUOcP5J0L/DzRHadM/0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=HByS45KRGutii0+dQfr2g5cywd19JHPVm0L4LXhrzKGQ5do8kLE+Od354Bbn+ekhSbrLDfvHEMhwpEWjYOxw8kIrGMosN4wyBDzy7aNSBUl+sJjxZAfBYzDhpVnKOoZnK5LenS8siEybw0XQbQlEcbF2ZyYt95er7241PA3i1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utHQFRF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C09C4CEED;
	Mon, 25 Aug 2025 18:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756145695;
	bh=J1MwtVp5jXRKRwKBsk/a5nbUIUOcP5J0L/DzRHadM/0=;
	h=Date:From:To:Subject:From;
	b=utHQFRF3TmNsnL3PaCIw4+HwJ5NSCyz10ABCwdA/6/wH55KfrbiVs5cVNm4TLmPrE
	 hLMXIafELjxLls8jR3gDIZ70BIKxn4Gf+0BPquR7xlkQKMdrb5pnbzmohVoNbT4OA3
	 EXCUPJrkchEJ1TTM8GadHvMwqXQPhURfwgyvjxIXFlhvf4dZi3If6MulYWesCwiKlh
	 rppKE8APYUGNj/A4eF73ojnU5dXnDijv+R2XhYsTDzlIKYmYfE1sx3xiYJFuzOE9Bo
	 iVxYHDBaC0I26W8ShK7CGpcnlacswAMvWhjmJvQip5i9J1hojBYf8n0j21XUKqH9Me
	 3L8Rm+So21CGw==
Date: Mon, 25 Aug 2025 11:14:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Aug 26th
Message-ID: <20250825111454.1cd36e5c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

No agenda at this stage. Please reply with suggestions, if no topics
are proposed 2h before the meeting we'll cancel.

