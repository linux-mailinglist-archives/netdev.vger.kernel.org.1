Return-Path: <netdev+bounces-141376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F119BA99D
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 00:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056E91F21447
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 23:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3256718BBA3;
	Sun,  3 Nov 2024 23:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDcS55ei"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA04189B95
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730677431; cv=none; b=bgXONTGWaEjFYNXnai4r6mRuUIw35CCUpDLEq6S0DV7MBDfcjSz/osd2ucXbbcjeyYHrhvvrF0QDSW6FUkTtXQ0+Uu7LLJKWb/tRbRIrRkFIYSwGtBh64zUThzxVoT6g5d8GRB/Ev2ba3ZlAUPdyWZug3PVBv1mqX5X7LToMNIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730677431; c=relaxed/simple;
	bh=Bde1C6VjOMy+OpqDPTROhjVJGHHqjVx7/dEomUxKWDk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Se+2YAHaduDKXmLinVD8deiZfLvbBf380RGJET+wRIQdw4e+kf9hwSdBgHF86UYzRxv2+e2ByluSuVM4CO+O0sEIsSnq9g9O/dab62/ma3mVQPBkRXbbvsMGQ6kHylnI9SeE2UfpPbjIuLzXM+MUb4Y7ZVnD3f/npOKZ1mZvN5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDcS55ei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02ACDC4CECD;
	Sun,  3 Nov 2024 23:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730677430;
	bh=Bde1C6VjOMy+OpqDPTROhjVJGHHqjVx7/dEomUxKWDk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DDcS55eiiWtW4QiBvDOB2PCa/Jhj7im5irZ+a0sNTIwa08cCiYonA8gYnT+H2rX7t
	 1Jxb9+RH/Vg0mNgoWvSFQM/VqKvgfPJhKgcX6ShdlMem2lJ0DbILK0Y9cud/Svt3Xq
	 PxE3dzqvfuD7niN5FxIlplNt271cPfKiU0/k1VYyg9VbhxPywbriGqxBciRqRt49BR
	 Yq0mgPf6Smr4PfhbCM04Wfr43p6WInGRlhL8j0HdeugzsZF7oAJg8LNHhPCtiefxGY
	 RAAXuOeoGIl0ZUfIpd867a0sqaYCcg8g32Qt4I2m5tft7UXc29OizKeZmkVWKzmJ5R
	 ugWYZKz/r1BOw==
Date: Sun, 3 Nov 2024 15:43:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, andrew@lunn.ch,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, kernel-team@meta.com, sanmanpradhan@meta.com,
 sdf@fomichev.me, vadim.fedorenko@linux.dev, horms@kernel.org,
 jdamato@fastly.com
Subject: Re: [PATCH net-next v4] eth: fbnic: Add support to write TCE TCAM
 entries
Message-ID: <20241103154348.792b663e@kernel.org>
In-Reply-To: <20241101204116.1368328-1-mohsin.bashr@gmail.com>
References: <20241101204116.1368328-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 Nov 2024 13:41:16 -0700 Mohsin Bashir wrote:
> Add support to redirect host-to-BMC traffic by writing MACDA entries
> from the RPC (RX Parser and Classifier) to TCE-TCAM. The TCE TCAM is a
> small L2 destination TCAM which is placed at the end of the TX path (TCE).
> 
> Unlike other NICs, where BMC diversion is typically handled by firmware,
> for fbnic, firmware does not touch anything related to the host; hence,
> the host uses TCE TCAM to divert BMC traffic.
> 
> Currently, we lack metadata to track where addresses have been written
> in the TCAM, except for the last entry written. To address this issue,
> we start at the opposite end of the table in each pass, so that adding
> or deleting entries does not affect the availability of all entries,
> assuming there is no significant reordering of entries.
> ---

--- will cut off the commit message when applying.
Your sign off has to be above it.
Please try to follow the mailing list to get a better grasp of 
the basics.

> Changes in V4:
> - Update the commit message to clearly specify the role of TCE TCAM in
>   fbnic
> - Revert iterator related changes made in V3 back to V2, including
>   iterator type and place of declaration
> 
> V3: https://lore.kernel.org/netdev/20241025225910.30187-1-mohsin.bashr@gmail.com
> V2: https://lore.kernel.org/netdev/20241024223135.310733-1-mohsin.bashr@gmail.com
> V1: https://lore.kernel.org/netdev/20241021185544.713305-1-mohsin.bashr@gmail.com
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
-- 
pw-bot: cr

