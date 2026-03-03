Return-Path: <netdev+bounces-263304-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD81JyQJp2k7bgAAu9opvQ
	(envelope-from <netdev+bounces-263304-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:15:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 006521F3740
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 17:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE411308ADEA
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 16:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553AD496914;
	Tue,  3 Mar 2026 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kc8DFsSg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3083F49690C;
	Tue,  3 Mar 2026 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554146; cv=none; b=RKoQJ7yFMT65h/F/605nJRKxkXmcyA83IQojjZm50hPURFZgJPy21UaYUDY6mPhbksc5vRfhzDdAPv5a7C1CUNvvATT3+uEps5DZtnI9FeQMnQdRaSKEnni2ZwfDlgpmFOfMPKaFZgANVQCUtebSrcTsRZR9Tsa28Iozcwff+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554146; c=relaxed/simple;
	bh=drpuhiPjMSKuQQ4zMinEz1gBi4DieQ5gfQ9BPqJNbdw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTLNPMEAYLE64R8R07tZ43G0b804H8jP5u+xeOJTyWtB78ntDxDtMaavZM5lMvd5BoshtgAJEB4xBcl0AykQTVdAW/E3dXMGrSNMGALsDa6Jes/1Op5p3PAEWGsLHJjXpR2ffWIkOVpO3IUiJtDbeElgPVjE/sMAT60k7iz5e0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kc8DFsSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA410C116C6;
	Tue,  3 Mar 2026 16:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772554145;
	bh=drpuhiPjMSKuQQ4zMinEz1gBi4DieQ5gfQ9BPqJNbdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kc8DFsSgeh3ZY2gVSJDdKiVI33Y8kR3BO0df8DKbJP6N3RHMmOcjAOCQq5KfK/2aI
	 MxEVE2UWtuHn+AAfZd5gLWI0IgxcvArtoKoaiYALvNNszeKyZhnhoJ8exuB3Gr/1k3
	 vVxPMBr/PGL+lnCNXC39hpj4zXUtANAI7H/hj/57F1mBNF7gHWxfzqhcmECll9ycoU
	 eqsXDTAmWtXlLABPrl2PhNwkz7R3269sX07ObMP1cb4fzq1Rga/xP/mBmOLryu+9Xh
	 DVWJs8Yd06/M3e/amonIdRt/wIebngyJ5dwRFx/C5N5CBWy034gpYikUh8t8UMAfSs
	 ShX3qLjkfcLZQ==
Received: from localhost ([::1])
	by mail.kernel.org with esmtp (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vxSIx-00000007ZYP-2Ep3;
	Tue, 03 Mar 2026 17:09:03 +0100
Date: Tue, 3 Mar 2026 17:09:02 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, "Lobakin, Aleksander"
 <aleksander.lobakin@intel.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook
 <kees@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [Intel-wired-lan] [PATCH 00/38] docs: several improvements to
 kernel-doc
Message-ID: <20260303170902.1ced0c3d@localhost>
In-Reply-To: <IA3PR11MB89867A79259D027E855F38DAE57FA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
	<33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
	<20260303155310.5235b367@localhost>
	<IA3PR11MB89867A79259D027E855F38DAE57FA@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 006521F3740
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263304-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Tue, 3 Mar 2026 15:12:30 +0000
"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com> wrote:

> > -----Original Message-----
> > From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Sent: Tuesday, March 3, 2026 3:53 PM
> > To: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Lobakin, Aleksander <aleksander.lobakin@intel.com>; Jonathan
> > Corbet <corbet@lwn.net>; Kees Cook <kees@kernel.org>; Mauro Carvalho
> > Chehab <mchehab@kernel.org>; intel-wired-lan@lists.osuosl.org; linux-
> > doc@vger.kernel.org; linux-hardening@vger.kernel.org; linux-
> > kernel@vger.kernel.org; netdev@vger.kernel.org; Gustavo A. R. Silva
> > <gustavoars@kernel.org>; Loktionov, Aleksandr
> > <aleksandr.loktionov@intel.com>; Randy Dunlap <rdunlap@infradead.org>;
> > Shuah Khan <skhan@linuxfoundation.org>
> > Subject: Re: [PATCH 00/38] docs: several improvements to kernel-doc
> > 
> > On Mon, 23 Feb 2026 15:47:00 +0200
> > Jani Nikula <jani.nikula@linux.intel.com> wrote:
> >   
> > > There's always the question, if you're putting a lot of effort into
> > > making kernel-doc closer to an actual C parser, why not put all that
> > > effort into using and adapting to, you know, an actual C parser?  
> > 
> > Playing with this idea, it is not that hard to write an actual C
> > parser - or at least a tokenizer. There is already an example of it
> > at:
> > 
> > 	https://docs.python.org/3/library/re.html
> > 
> > I did a quick implementation, and it seems to be able to do its job:

...

> 
> As hobby C compiler writer, I must say that you need to implement C preprocessor first, because C preprocessor influences/changes the syntax.
> In your tokenizer I see right away that any line which begins from '#' must be just as C preprocessor command without further tokenizing.

Yeah, we may need to implement C preprocessor parser in the future,
but this will require handling #include, with could be somewhat
complex. It is also tricky to handle conditional preprocessor macros,
as kernel-doc would either require a file with at least some defines
or would have to guess how to evaluate it to produce the right
documentation, as ifdefs interfere at C macros.

For now, I want to solve some specific problems:

- fix trim_private_members() function that it is meant to handle
  /* private: */ and /* public: */ comments, as it currently have
  bugs when used on nested structs/unions, related to where the
  "private" scope finishes;

- properly parse nested struct/union and properly pick nested
  identifiers;

- detect and replace function arguments when macros with multiple 
  arguments are used at the same prototype.

Plus, kernel-doc has already a table of transforms to "convert"
the C preprocessor macros that affect documentation into something
that will work.

So, I'm considering to start simple, for now ignoring cpp, addressing
the existing issues. 

> But the real pain make C preprocessor substitutions IMHO

Agreed. For now, we're using a transforms list inside kernel-doc for
such purpose. So, those macros are manually "evaluated" there, like:

	(KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),

This works fine on trivial cases, where the argument is just an ID,
but there are cases were we use macros like here:

    struct page_pool_params {
	struct_group_tagged(page_pool_params_fast, fast,
		unsigned int	order;
		unsigned int	pool_size;
		int		nid;
		struct device	*dev;
		struct napi_struct *napi;
		enum dma_data_direction dma_dir;
		unsigned int	max_len;
		unsigned int	offset;
	);
	struct_group_tagged(page_pool_params_slow, slow,
		struct net_device *netdev;
		unsigned int queue_idx;
		unsigned int	flags;
    /* private: used by test code only */
		void (*init_callback)(netmem_ref netmem, void *arg);
		void *init_arg;
	);
    };

To handle it, I'm thinking on using something like this(*):

	CFunction('struct_group_tagged'), r'struct \1 { \3 } \2;')

E.g. teaching kernel-doc that, when:

	struct_group_tagged(a, b, c)

is used, it should convert it into:

	struct a { c } b;

which is basically what this macro does. On other words, hardcoding
kernel-doc with some rules to handle the cases where CPP macros
need to be evaluated. As there aren't much cases where such macros affect
documentation (on lots of cases, just drop macros are enough), such
approach kinda works.

(*) I wrote already a patch for it, but as Jani pointed, perhaps
    using a tokenizer will make the logic simpler and easier to
    be understood/maintained.

-- 
Thanks,
Mauro

