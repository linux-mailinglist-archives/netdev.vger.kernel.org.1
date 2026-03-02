Return-Path: <netdev+bounces-262724-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIBEH421pWkiFQAAu9opvQ
	(envelope-from <netdev+bounces-262724-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:06:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B531DC5D6
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 02A1930015A1
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 15:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA7C421EFF;
	Mon,  2 Mar 2026 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgDRLpR1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFA44219F4;
	Mon,  2 Mar 2026 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466877; cv=none; b=j7/qsZnRx8Q4cdQbbTKY5mcvMQdcX5dOMKNRJkMHIfS+nQMrmfN0UgJJ7N2sCmjmnWstoXYhpD9i23rUG73kxdK23DD8Fna88a/kdqSiXotJmYOva9CGZ8HS/XpKe8qqM3kqd7n6Ol9FWC8AH7v0SE2g3CUhjmpdTF++CfERFd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466877; c=relaxed/simple;
	bh=3BQmq9dvDpl2+fop+k6JBpifN8Rg7E6/3o3+NwzLUys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPfnT3OWuvYA59pXkj+CAdQXTUuijTS+PVjes82TQoFM2QoyCb1f15r5wbiND4S7AB4p9nKuyyWW8XWj30JG2lGSzYGH+U7sEe+xaAK5uIXm7KKt5BDifl7JnqyxPitMjeTTxqRmU3ToST/GvuT47Tmg8rKIMjdN1efM+utKv9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgDRLpR1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D4EC2BC87;
	Mon,  2 Mar 2026 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772466876;
	bh=3BQmq9dvDpl2+fop+k6JBpifN8Rg7E6/3o3+NwzLUys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jgDRLpR1lV5Tw0Ecq/vLiVK0zxCyZGfh1QQbGSPkdVdk1kFg7jD5JrKWWujT+3ecn
	 RjXtWbXFBDkmX7zxn30hP1eQwct2sf7gJb1MzO1hPFScV+HwOVAPZ5NAFNcsGl/JbI
	 eAVuF1oT4mtua5qCAOSkJ0A3nSHPDpAMyGacFS/ugKah1ihP+Fr8LZy6rriEy4chT7
	 f4eyrHL4vKxvgQ02eB5Fz+VSkK9pN0/GX8il4ctbFuZcp5j4Afl5dTpoP058MHmxwM
	 DXYNh6GjhipUwJDF3NojaQIG5EBzIqcCyrCtCTW6IsPV+/P3ZOFPNIPM61nOqBe5cr
	 Tn9PETygu4k/Q==
Received: from localhost ([::1])
	by mail.kernel.org with esmtp (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vx5bO-0000000GuZ0-2ElO;
	Mon, 02 Mar 2026 16:54:34 +0100
Date: Mon, 2 Mar 2026 16:54:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Kees Cook
 <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [Intel-wired-lan] [PATCH 00/38] docs: several improvements to
 kernel-doc
Message-ID: <20260302165433.27f11148@localhost>
In-Reply-To: <87sear2kbm.fsf@trenco.lwn.net>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
	<87sear2kbm.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 80B531DC5D6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262724-lists,netdev=lfdr.de,huawei];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 14:58:53 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Hi Jon,
> >
> > This series contain several improvements for kernel-doc.
> >
> > Most of the patches came from v4 of this series:
> > 	https://lore.kernel.org/linux-doc/cover.1769867953.git.mchehab+huawei@kernel.org/  
> 
> So I will freely confess to having lost the plot with this stuff; I'm
> now trying to get back up to speed. 

Yeah, I kinda figure it out ;-)

> But, before I dig into this big
> series, can you say whether you think it's ready, or whether there's
> another one on the horizon that I should wait for?

There are more things undergoing, but I need some time to reorganize
the patchset... currently, there are 60+ patches on my pile.

So, instead of merging this patchset, I'll be sending you
a smaller series with the basic stuff, in a way that it would
be easier to review. My plan is to send patches along this week
on smaller chunks, and after checking the differences before/after,
in terms of man/rst/error output.

-- 
Thanks,
Mauro

