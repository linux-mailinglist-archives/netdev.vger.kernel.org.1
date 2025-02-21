Return-Path: <netdev+bounces-168337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7584BA3E968
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3DD18888FA
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA641A270;
	Fri, 21 Feb 2025 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRn3UVDb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1965979F2
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740099244; cv=none; b=MGt1trnf7Bf6QCGkK36tslsmLv3dQVA557kKzWcy7LNVMmUiGSlmvZxwjQOxPBXhmFmo5yUQZMOd5D3phEYnIWZzDbzet5f8tq8ov8fTjDB77ssFIhaedJczQRwilVikX44vfOGq5/2IX70CxwxYQrsG4gVfpd/ucRui/GSNHsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740099244; c=relaxed/simple;
	bh=1ZBxco0n5SWaW4oCmFsZ5anpw15XneMnu728piBhWjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fx3xTSXyZGKJfYuBFoJmqMrfdtyu7oYoMqv/WYXF2dhkrNrOFtf0kPiCzXxWYBrWF3XBoaolaroTG8szZDcX0ZP2WwEB4j4jmoFZUdBQ5wr1AiGb3DvxOblQbHPRdSoRUuj1VZibTEFVqpG1/W7RMru8ERqtO7gdLAvrCbOa2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRn3UVDb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E440C4CEF2;
	Fri, 21 Feb 2025 00:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740099243;
	bh=1ZBxco0n5SWaW4oCmFsZ5anpw15XneMnu728piBhWjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cRn3UVDbd1YetAmm2tqmv+g0i1b+YjtRx4TBcYS6w/hCYDYMvthiM6kFugciSEDor
	 s883+/sAxSZJ0gUlG4AcBvuvr7kJDewtOJne51M1yH0ELPMRwC6cELOqNNSAJ97idf
	 aAMnXqO4LMsbo3ShG+HVNsPcYyxV1h6MT9bL65lAxj+A3XLJWVaDMU2XIewBmKnRmX
	 UHFsTi2Y1kPWnMlQnrRnn/IBgu8Hn1nyEdu4JBFqOqjmZii7XdY9wGR5QicWXVM1bw
	 EK9TFNcHnzEQ6AcSk1AbmfMOq/4HJKzTGwKIRPBdeIAhnk0NyVVCJENnNBi2QDj82H
	 K4Nw6TSr8kODg==
Date: Thu, 20 Feb 2025 16:54:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Pablo Martin Medrano <pablmart@redhat.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net] selftests/net: big_tcp: longer netperf session on
 slow machines
Message-ID: <20250220165401.6d9bfc8c@kernel.org>
In-Reply-To: <bd55c0d5a90b35f7eeee6d132e950ca338ea1d67.1739895412.git.pablmart@redhat.com>
References: <bd55c0d5a90b35f7eeee6d132e950ca338ea1d67.1739895412.git.pablmart@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 17:19:28 +0100 Pablo Martin Medrano wrote:
> After debugging the following output for big_tcp.sh on a board:
> 
> CLI GSO | GW GRO | GW GSO | SER GRO
> on        on       on       on      : [PASS]
> on        off      on       off     : [PASS]
> off       on       on       on      : [FAIL_on_link1]
> on        on       off      on      : [FAIL_on_link1]
> 
> Davide Caratti found that by default the test duration 1s is too short
> in slow systems to reach the correct cwd size necessary for tcp/ip to
> generate at least one packet bigger than 65536 (matching the iptables
> match on length rule the test evaluates)

Why not increase the test duration then?

