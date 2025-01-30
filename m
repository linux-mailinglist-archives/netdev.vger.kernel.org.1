Return-Path: <netdev+bounces-161574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5C3A22743
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 01:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53AA3A7002
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 00:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF727464;
	Thu, 30 Jan 2025 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAZzq8ZX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3D4C79;
	Thu, 30 Jan 2025 00:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738197558; cv=none; b=YyWjEuoRNAaHFS9JHQMtypODzwOZdZlbYCX4Plu/i6K97Y9k430rWZbey3UeTdo2oqZh6B/WC+1Z/ICsEEtU5+rhLKMk1z3BYFcUhB8AQEXTidqEGx9z39jmgPH9j93An+Zo31xgfPZyxfnK1pxFAPFO6pwtXkp6Byvxig1bQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738197558; c=relaxed/simple;
	bh=WQQRBTG8nViAwagWRgVW8s+Tgu2sdifMLiyfQMot608=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PIrGCa0KLFSHorPyKzRlobdLMTWcr03IA0cG0VbJ6AZxjxNkOMsmpXtqbGimLqvGfTcdqvLT6Z40Ow3gedThRfN7PSQRV5Wo1L28ZQ2JTPU8xOt+J7YbcgGaaGXc8FvnITOCfKqqOTF6lNSX3QMgrsmJyp3OH2ECTG0t9wl2pvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAZzq8ZX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FDFC4CED1;
	Thu, 30 Jan 2025 00:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738197557;
	bh=WQQRBTG8nViAwagWRgVW8s+Tgu2sdifMLiyfQMot608=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NAZzq8ZXN0wFZZytsnIYXqDTmq1Q5HoY8fzprKJVJfb4SF0p7CKlmCoRAUWdnuWex
	 pngyQwSwJeSxYjGkWBT6k3Djh1qoBGaNY/wdLl1ciyebhLJzULdvCPrrP+xMaC3Bda
	 bBRtFAIPyjtebPz8wJlrhYek7o1DgQABD5HMpmm7EgRDWDQyk9HFLbaovIrpUNt/R+
	 SXlg27Fs2RU0yDzlxlRszk0zSLGhOo+A9yiNUgQYZto0mxfWYQb/g29h94u580NE+V
	 n44wmMEnMg19mqWVTZN2uwWOjEXxO64MmpmZSDw2rwbzyNYNb/h8Zg4DvcPIzFV4w1
	 1QswOibGnHozg==
Date: Wed, 29 Jan 2025 16:39:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net 1/3] MAINTAINERS: Add myself as maintainer for
 socket timestamping and expand file list
Message-ID: <20250129163916.46b2ea5c@kernel.org>
In-Reply-To: <20250128-fix_tsconfig-v1-1-87adcdc4e394@bootlin.com>
References: <20250128-fix_tsconfig-v1-0-87adcdc4e394@bootlin.com>
 <20250128-fix_tsconfig-v1-1-87adcdc4e394@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 16:35:46 +0100 Kory Maincent wrote:
> Add myself as maintainer for socket timestamping. I have contributed
> modifications to the timestamping core to support selection between
> multiple PTP instances within a network topology.
> 
> Expand the file list to include timestamping ethtool support.

Hi Kory, is there more context you could provide for this change?

For core pieces of the stack, with a long history, we tend to
designate as maintainer folks who review the changes, not just
write code. According to our development stats that doesn't
describe you, just yet:

Top reviewer score:

6.12: Negative # 5 ( +6) [ 50] Kory Maincent (Dent Project)
6.13: Negative #11 (***) [ 29] Kory Maincent (Dent Project)

https://lore.kernel.org/20250121200710.19126f7d@kernel.org
https://lore.kernel.org/20241119191608.514ea226@kernel.org
https://lore.kernel.org/20240922190125.24697d06@kernel.org

That said, I do feel like we're lacking maintainers for sections 
of the ethtool code. Maybe we could start with adding and entry 
for you for just:

> +F:	net/ethtool/tsconfig.c
> +F:	net/ethtool/tsinfo.c

Does that sound fair?

