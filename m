Return-Path: <netdev+bounces-184022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FBCA92F62
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 03:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3965F19E7348
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 01:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7B51DED54;
	Fri, 18 Apr 2025 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcqJYrmc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA11D8A14
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744940305; cv=none; b=YbjI4Dlp4BAJ2lPWvLmmwXVWLaiuWezZx7y1awEMd+RurmEbYnQdWIDakOgGDNvqczrGVsXv8g6rGDBMmdPZWDj4G4g1gapvSFWx2182Yv/hy9ivTzREiH7gzw+kCWiSZzTTp/7G/KE61PGwG8WSzWIuobgs1Bholmlp/bXJ7fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744940305; c=relaxed/simple;
	bh=2eIRD/GZRVUTSXR0QSl+2QvbIGGuLZUMRNj638i3RYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bcdPrsPNuVRKv7R3hcHhYWCG/nRPdGx+o3/pcst/A3v0yCDFEVhvX+Db/u1Z0nSLv/UWCRrhNz1ZdI5i6OgIkU1wGAJn7ozhlQVAoefXJyMiv9gc4Hynz2SVdkmZV8BYVcYz5HVvvOZFgHR8WqhpBFuITidDfNoRRPWUXzGgMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcqJYrmc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4E4C4CEE4;
	Fri, 18 Apr 2025 01:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744940304;
	bh=2eIRD/GZRVUTSXR0QSl+2QvbIGGuLZUMRNj638i3RYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OcqJYrmcK9hmIN5NbODG/DOLxZ7Xmi4i1nfJ4IZdu4SVpm9iO5fVnhiDrlDb/nop+
	 b1R7Mb+Qfmq6UmlxpSZ8BFRJeLJC9CJhyGc/skV35LTMTWbQzzfemBf7isDtwUOuXJ
	 12d04Ul6DS6oHSD+Fnsk/Hp635su2ZelSnNc0xZRTtQ7IqCBM+fkhmAPVx+ERX7X+b
	 qSe2Tq9vdzk3+xneAUOlT20ZvbCvUixFYvECeF7xp5eck34KYHQ/BqZOTJiKXp/apw
	 vQCB5dENepp3oEUmzYpVkFb/+jMDZ/6mKkg6s2FMadOBMLxDp49sYvOufWWZ6qMICE
	 v1zhcHWwIcrCA==
Date: Thu, 17 Apr 2025 18:38:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 parav@nvidia.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH net-next v3 2/3] devlink: add function unique identifier
 to devlink dev info
Message-ID: <20250417183822.4c72fc8e@kernel.org>
In-Reply-To: <20250416214133.10582-3-jiri@resnulli.us>
References: <20250416214133.10582-1-jiri@resnulli.us>
	<20250416214133.10582-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Apr 2025 23:41:32 +0200 Jiri Pirko wrote:
> A physical device may consists of several PCI physical functions.
> Each of this PCI function's "serial_number" is same because they are
> part of single board. From this serial number, PCI function cannot be
> uniquely referenced in a system.
> 
> Expanding this in slightly more complex system of multi-host
> "board.serial_number" is not even now unique across two hosts.
> 
> Further expanding this for DPU based board, a DPU board has PCI
> functions on the external host as well as DPU internal host.
> Such DPU side PCI physical functions also have the same "serial_number".
> 
> There is a need to identify each PCI function uniquely in a factory.
> We are presently missing this function unique identifier.
> 
> Hence, introduce a function unique identifier, which is uniquely
> identifies a function across one or multiple hosts, also has unique
> identifier with/without DPU based NICs.

Why do you think this should be a property of the instance?
We have PF ports.

