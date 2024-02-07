Return-Path: <netdev+bounces-69871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A43984CE0A
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15E9328AFBC
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 15:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F517F7DF;
	Wed,  7 Feb 2024 15:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahmZAQRq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113B7E775;
	Wed,  7 Feb 2024 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319755; cv=none; b=IEPqkYX3jr9NlzkwP1DDzv3/UW6e2ddpXwMUTqMvY5C0KUJ0+ZSW3nAr6w9K/kZVKyjZiA0OZrnA1GtS4TAj5o+8hemo8lk8YMTO7clRbigCwaB1nsgRPQZ0vnDQLdsFYaCKgdLZ1KnNhcxIGa9M7bS/UHZwVLWPfwd5LVLtsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319755; c=relaxed/simple;
	bh=JWviqLWSlkjLE1/8WvC8zTpCHoR7PyALE6nthzU0xjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOlE5mugqdcszxmqviQT+hG5aXeU/Q2LdP8KybktW0yJQRDa2aIKWlCxMrkd74aczf2fpSD8Sso3prR2j1Gh15JEMQAQpt76y71qQczEGueswUGSSfwZikfNfsyM27AeUlDf6V1ub4ccyxCegbpgqSPzc+qU/Q+wE/cSiyFOJkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahmZAQRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2417BC433C7;
	Wed,  7 Feb 2024 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707319754;
	bh=JWviqLWSlkjLE1/8WvC8zTpCHoR7PyALE6nthzU0xjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ahmZAQRq7Ylcy0DCBteiiZhf56yvtHOGm3NI+PJZFwn0ScULRFohqc1WVGm5CiVaE
	 +rkyrxxiWe46P6X1AwX/+ioACVvl0L8WY65GQCMlt3+wzYTQxO3V3PKmwpd6tNDnuW
	 YCaZpl3NK04Ox4afBR4uXBe/CdhUaNd3P3kztvJmlDZ78D2kDGZ9xYMwTnjzEHjc7m
	 j6dWgGEJEDJecaBIpQSf1/OJunZeUbuFGj740DIOuhluT+PlXG7hfR9j2sPoK/D7n+
	 DbUciKWdd/AK3fVbXuvTZsiAt9sOGWmh/0DQoDsOYfEsLqUSjNmcZ4oAyEYdqE5d3j
	 TWQqKBFz0H7Iw==
Date: Wed, 7 Feb 2024 07:29:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, MPTCP Upstream
 <mptcp@lists.linux.dev>, Paolo Abeni <pabeni@redhat.com>, Mat Martineau
 <martineau@kernel.org>
Subject: Re: [TEST] The no-kvm CI instances going away
Message-ID: <20240207072913.0c69225c@kernel.org>
In-Reply-To: <e216081b-8755-46be-a687-2c61d335aedb@kernel.org>
References: <20240205174136.6056d596@kernel.org>
	<f6437533-b0c9-422b-af00-fb8a236b1956@kernel.org>
	<20240206174407.36ca59c4@kernel.org>
	<2d0eb4ef-dd07-4800-8fcf-637a924570fa@kernel.org>
	<20240207062540.5fe5563b@kernel.org>
	<e216081b-8755-46be-a687-2c61d335aedb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Feb 2024 15:37:22 +0100 Matthieu Baerts wrote:
> > I'd rather not modify the tree. Poking around - this seems to work:
> > 
> >   export kselftest_override_timeout=1  
> 
> Even better :)
> 
>   f=tools/testing/selftests/net/settings
>   kselftest_override_timeout=$(awk -F = '/^timeout=/ {print $2*2}' $f)
> 
> > Now it's just a matter of finding 15min to code it up :)  
> I'm not sure if I can help here :)

If you're willing to touch my nasty Python - that'd be very welcome! :)

Right now I put this in the configs:

[vm]
exports=KSFT_MACHINE_SLOW=yes

We can leave the support for adding exports in place, but we should add
a new config option like

[vm]
slowdown=2

(exact name up for debate), if it's present generate the
KSFT_MACHINE_SLOW=yes export automatically, without the explicit entry
in the config. And add the export for the timeout matching the logic
you propose (but in Python).

FWIW here's the configs we currently use:

$ cat remote.config
[remote]
branches=https://netdev.bots.linux.dev/static/nipa/branches.json
filters=https://netdev.bots.linux.dev/contest/filters.json
[local]
results_path=results
json_path=jsons
[env]
paths=/home/virtme/virtme-ng/
[vm]
paths=/home/virtme/tools/fs/bin:/home/virtme/tools/fs/sbin:/home/virtme/tools/fs/usr/bin:/home/virtme/tools/fs/usr/sbin
ld_paths=/lib64/:/home/virtme/tools/fs/usr/lib/:/home/virtme/tools/fs/lib64/:/home/virtme/tools/fs/usr/lib64/
init_prompt=bash-5.2#
default_timeout=200
boot_timeout=45


$ cat ksft-mptcp-dbg.config
[executor]
name=vmksft-mptcp-dbg
[local]
tree_path=/home/virtme/testing-12/
base_path=/home/virtme/outputs-12/
[www]
url=https://netdev-3.bots.linux.dev/vmksft-mptcp-dbg
[vm]
exports=KSFT_MACHINE_SLOW=yes
configs=kernel/configs/debug.config,kernel/configs/x86_debug.config
default_timeout=300
cpus=4
[ksft]
target=net/mptcp
[cfg]
thread_cnt=1


