Return-Path: <netdev+bounces-248729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A97ED0DAAD
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 20:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A48FE3004E2E
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 19:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0C1299AB4;
	Sat, 10 Jan 2026 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUpf/5eh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C3285068
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 19:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768072078; cv=none; b=NZ7hsaRN+eL/GqnLEtJGatNJljT+5ylkPqduf5xokfNFOpwS6Zf5PKvFBt8x0iedgw1BJ0jyVXuGN6XXUJFaPD5XVEfuXSGchABX2B1BzQ/EdpeFjjChZUQSjMlukDl0Awc+9Vwb+gFGO+d8Eh5gPXUmgxgi1Nf9nNCe98XV8WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768072078; c=relaxed/simple;
	bh=ZXi1A4cxWg+/v5f+5t+ZCY/Fz6vJm8MDxTNo5+I/qq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lA26XwURklQ3USNnAZxuNzc0EIVHTtPuIS7f2QCEjMg/UHWGezJAucSJR6t/6EiQOH/mTxMmiCZXHbo4AeRBFchNTi4Q8B1vMx0rq1NUyjaMz4d5RepCSXBLx+8z2m9rpZV0XW4tMpb4hO4NoAVWav3m3FbFeHS1d/fobcw/YzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PUpf/5eh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB864C4CEF1;
	Sat, 10 Jan 2026 19:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768072078;
	bh=ZXi1A4cxWg+/v5f+5t+ZCY/Fz6vJm8MDxTNo5+I/qq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PUpf/5ehYGjmaEwO84uqv5ioQKYhvPqHKNUH+/TXZFATG0rzs/kOG5O7N/Mjx3YEL
	 nT6ayg6tX7AGCx2Y9ZYJyP6B3suSNohWgcQIAV4r90OqfO3GF5gCOeOWxBHgq05zyK
	 79kEI5rEim2nc9pwQTbtxEvbTFyoyPtBAaKeK9OzbTtRG26qgqTf2fsuhvbR2C1wwr
	 ssEEN6kocthSoMa/HG4yDCyJlNVoHE+ajsdysBwBemBJOBjD+DKbsJbZSWCmzlb6e5
	 29l3wiFo8mr7oxGGBmdFYwH4Ly9gnou9/ryi/f+smC3H7k/yVW/Yw17FdlnvKOruaJ
	 I5mvY1V3Pk6Gg==
Date: Sat, 10 Jan 2026 11:07:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, gal@nvidia.com
Subject: Re: [PATCH net-next 2/7] tools: ynl: cli: wrap the doc text if it's
 long
Message-ID: <20260110110757.6dde2d45@kernel.org>
In-Reply-To: <aWKiqKPYiAeeyhPq@mini-arch>
References: <20260109211756.3342477-1-kuba@kernel.org>
	<20260109211756.3342477-3-kuba@kernel.org>
	<aWKiqKPYiAeeyhPq@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Jan 2026 11:04:08 -0800 Stanislav Fomichev wrote:
> > @@ -101,7 +102,14 @@ RELATIVE_SCHEMA_DIR='../../../../Documentation/netlink'
> >                  attr_info += f" -> {nested_set_name}"
> >  
> >              if attr.yaml.get('doc'):
> > -                doc_text = textwrap.indent(attr.yaml['doc'], prefix + '  ')
> > +                doc_prefix = prefix + ' ' * 4
> > +                if sys.stdout.isatty():
> > +                    term_width = shutil.get_terminal_size().columns
> > +                else:
> > +                    term_width = 80
> > +                doc_text = textwrap.fill(attr.yaml['doc'], width=term_width,
> > +                                         initial_indent=doc_prefix,
> > +                                         subsequent_indent=doc_prefix)  
> 
> Any specific reason you wrap to 80 for !isatty?

not really, just the default width of a classic terminal
the textwrap library defaults to 70 which is another option tho
I doubt there's a strong reason behind that value either..

