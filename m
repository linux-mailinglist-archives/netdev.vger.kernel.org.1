Return-Path: <netdev+bounces-64152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8218316CA
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 11:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D70B22589
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E940922F05;
	Thu, 18 Jan 2024 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijP6HBOB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56EDB65C
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 10:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705574981; cv=none; b=McNYXRUibEKrXZN2BJTCn3yQGW49FdRegm5U/HXQdBytvgoiNXVUnjGg5zWW3S0OiTyfsmUH0JMmoh6BXXj3k6viIci62ooHF/FYBd3mcSivdRHKTx8CFkH3RXsbv0/daGA6ExNs7wrv4r8LnjlfB3E5O7qKXV8qN4iEEUMUKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705574981; c=relaxed/simple;
	bh=kd8LgSZxirFhyh2ufxr1bCvtuZbcD/SJjtfA3iGtLKk=;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:
	 Organization:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	b=o06I9aVzgF408Ct6PaDJu76/2R8w+R+/x4lR0z6V8Uk510Hm1JOHDguPiONNxBBIN7Ro4gYE/o0imYyo3mwY0M0ucWVNEgXOorGYRIy0vpOkPNZwUeA5jf5GggsoDOa8pOlpvoUa1EyuRL0JmZB3YIS0jKyEzxsDft2vbt3k5t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijP6HBOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543BFC433C7;
	Thu, 18 Jan 2024 10:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705574981;
	bh=kd8LgSZxirFhyh2ufxr1bCvtuZbcD/SJjtfA3iGtLKk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ijP6HBOBHicx12Q3XOUR0EhVUcLIJxF5HhcLOgIhu6eUGvuLLPERVzDUITCeWGet7
	 KzjMyXJbIlGtOYlNd+J4nl4ByoBVS9cgjSWuHPxbjivZ4Itbjm4itWVHrZdWgHVkCV
	 kDRr2yLfjAjkh5pQpIVD5lvnLvcqAlGmUyiX9AfXbujbBRgpqylLzQEE6K4MZ2KRho
	 1F99DFtIzzX/OXmZtaar1/S1LzDhDmGdJZMyQvbv5GVtuV9sq6tfX0Ifu7Fb91Keau
	 Ms4yYVSQnUlKzK0UoyTkEOeONYy1ypfozfa2bl73oic9oo+TMEdgScgOvhh7Zt3iwl
	 4rGXyMYuLrpRA==
Message-ID: <fcee4777-4e46-46c6-8ffd-938b00841958@kernel.org>
Date: Thu, 18 Jan 2024 11:49:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC iproute2 v6 2/3] ss: pretty-print BPF socket-local storage
Content-Language: en-GB, fr-BE
To: Quentin Deslandes <qde@naccy.de>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 David Ahern <dsahern@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 kernel-team@meta.com
References: <20240118031512.298971-1-qde@naccy.de>
 <20240118031512.298971-3-qde@naccy.de>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240118031512.298971-3-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Quentin,

Thank you for working on that!

On 18/01/2024 04:15, Quentin Deslandes wrote:
> ss is able to print the map ID(s) for which a given socket has BPF
> socket-local storage defined (using --bpf-maps or --bpf-map-id=). However,
> the actual content of the map remains hidden.
> 
> This change aims to pretty-print the socket-local storage content following
> the socket details, similar to what `bpftool map dump` would do. The exact
> output format is inspired by drgn, while the BTF data processing is similar
> to bpftool's.
> 
> ss will use libbpf's btf_dump__dump_type_data() to ease pretty-printing
> of binary data. This requires out_bpf_sk_storage_print_fn() as a print
> callback function used by btf_dump__dump_type_data(). vout() is also
> introduced, which is similar to out() but accepts a va_list as
> parameter.
> 
> COL_SKSTOR's header is replaced with an empty string, as it doesn't need to
> be printed anymore; it's used as a "virtual" column to refer to the
> socket-local storage dump, which will be printed under the socket information.
> The column's width is fixed to 1, so it doesn't mess up ss' output
> (expect if --oneline is used).

Do you really need this new column, then?

Why not printing that "at the end", in the COL_EXT column, like many
extra and optional bits: TCP Info, CGroups, memory, options, etc.

Here, it seems a bit confusing: if I understand correctly, these extra
and optional bits are handled first, then back to the previous column
you added (COL_SKSTOR) to always iterate over the BPF storages, and
maybe print more stuff only if the new option is given, optionally on
new lines. Would it not print errors even if we didn't ask to display
them, e.g. if the size is different from the expected one?
Would it not be simpler to extend the last column?
If you do that, you will naturally only fetch and iterate over the BPF
storages if it is asked to print something, no?

To be honest, it looks like there are too many options that can be
displayed, and there are probably already enough columns. That's
certainly why no other columns have been added for years. I don't know
why there was an exception for the "Process" one, but OK.
I do think it would be better to have a new "--json" option to structure
the output and ease the parsing, than having workarounds to improve the
output and ease parsing of some options. But that's a more important task :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

