Return-Path: <netdev+bounces-254377-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF4WBclHemkp5AEAu9opvQ
	(envelope-from <netdev+bounces-254377-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:30:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B6FA6F07
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9996E3041B36
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B20533EAE7;
	Wed, 28 Jan 2026 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jfz/d2EP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18737230BF6;
	Wed, 28 Jan 2026 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620663; cv=none; b=oypIaBmAj0lLmjj5tDTDU2rFEsUN6412/bihjU0/fKLvWLp03g584wSRihK8K0h2vip1fQW4dp/Q+CSj7i/CTU7fasCwmPQiPnkPsuwGuq1r+OwnlRs8QeYEVCCJkQH/XdC5ZvCKAsrJg5B5Qn4rLVeouy0GH1+ThiU3We8UXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620663; c=relaxed/simple;
	bh=ANTjixZkXhjfEXZHVJOVnZ6wtyrPwuI6BH+sQY3XRDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+pmJMVOnIeibx62ve2tTnA2Ie8gMbY7VXaSXqZ7/snwehY7xPZ+JLh82mnxcQn+sDJkCF9+HBMNpsKNQjhOhBmCJoTRx95sfjETR1fOC01qcVIKsi+okrWY/LiJvyFRO3VV+uUPSUmuPfwOYsuzagO1hd0n3dNHFfh4q8TBCKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jfz/d2EP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C852DC4CEF7;
	Wed, 28 Jan 2026 17:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769620662;
	bh=ANTjixZkXhjfEXZHVJOVnZ6wtyrPwuI6BH+sQY3XRDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jfz/d2EPfEfEFSwxM75CsatguEfliiHE/4PaQGlLTfUwy1Uh9eZrb98Taq97Qv/jP
	 cJBvDa5uSiq7rM1YMawbMbu53LfmyMcTN+iugV/ld829vY17c1pACLKs8vRPawUqSm
	 rQb/Vm3wb50pO8F/JtHBocxmTEMdHoOdt/mAAMoNra0bR5azYbhYLmt+zbYNIF0p7C
	 gdbavaoLYW0d2mp1G0ZuTtBPJQ7FV/cbo9v8Mjfrsd+lbATvxsTUi4tcLmCDPDh2UE
	 6zWY+7g/lOoDyMJ+AISad5F63MsZKGXH7akyw8BAjjAfICsrMq9oc3Xi8irMVQuKPO
	 1H2F1jeB+OcHw==
Date: Wed, 28 Jan 2026 18:17:35 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v2 23/25] tools/lib/python/unittest_helper.py
Message-ID: <20260128181735.32201f69@foz.lan>
In-Reply-To: <f370f2a0dfcaa679c9969488c908eaac82026031.1769617841.git.mchehab+huawei@kernel.org>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
	<f370f2a0dfcaa679c9969488c908eaac82026031.1769617841.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-254377-lists,netdev=lfdr.de,huawei];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 52B6FA6F07
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 17:50:21 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This is obviously wrong... it should have been merged with patch 21, after
a cleanup I did on it to remove some dead code.

> ---
>  tools/lib/python/unittest_helper.py | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/tools/lib/python/unittest_helper.py b/tools/lib/python/unittest_helper.py
> index e438472fa704..3cf1075b1de4 100755
> --- a/tools/lib/python/unittest_helper.py
> +++ b/tools/lib/python/unittest_helper.py
> @@ -8,21 +8,7 @@
>  Helper class to better display unittest results.
>  
>  Those help functions provide a nice colored output summary of each
> -executed test and, when a test fails, it shows the different in diff
> -format when running in verbose mode, like::
> -
> -    $ tools/unittests/nested_match.py -v
> -    ...
> -    Traceback (most recent call last):
> -    File "/new_devel/docs/tools/unittests/nested_match.py", line 69, in test_count_limit
> -        self.assertEqual(replaced, "bar(a); bar(b); foo(c)")
> -        ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -    AssertionError: 'bar(a) foo(b); foo(c)' != 'bar(a); bar(b); foo(c)'
> -    - bar(a) foo(b); foo(c)
> -    ?       ^^^^
> -    + bar(a); bar(b); foo(c)
> -    ?       ^^^^^
> -    ...
> +executed test.
>  
>  It also allows filtering what tests will be executed via ``-k`` parameter.
>  



Thanks,
Mauro

