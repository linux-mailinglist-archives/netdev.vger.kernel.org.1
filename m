Return-Path: <netdev+bounces-192913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29CEAC19FE
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 04:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE4317E7FD
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 02:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA312DCC0D;
	Fri, 23 May 2025 02:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWMkJKZn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1A12DCBF7
	for <netdev@vger.kernel.org>; Fri, 23 May 2025 02:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747966658; cv=none; b=tZkuzL7IrF6Xk38YPSDc56eFVPTG82o58ERnjo7QjsyMjWIZj3PUswrH6fJ/Ot7+b3QvnYntV++FXNd+d+u2urjjPixnJxKTB6YA9SthzK7GFBafpOeo40EVQwj7UPpI3jmwX3B1//+bMrzfAcT8L4Sb5Yp5/ruq+gu6ZvI9Pd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747966658; c=relaxed/simple;
	bh=GTxgn62E3xl6aFsnRl/mIJJzCdFyugE2/ille0y1FMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2+tXqeyak1fYIhFK7V3G55RXbsAbyPFJAH6O8wXPLrVZzFqB6RTEMqtEUdaT4CPr9Dp3r4wZrmNqlJfAPbCyHVi/SfSbaM0Rujeou9Uw3b1ZAtBmNVaBv2TPPuxPmYvZo1GkO7QtbNiP6y7amHZaQDZYzAaRaGlVRs43kdVyvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWMkJKZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E54C4CEE4;
	Fri, 23 May 2025 02:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747966658;
	bh=GTxgn62E3xl6aFsnRl/mIJJzCdFyugE2/ille0y1FMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CWMkJKZnaP+h2fwLtymfffmm2Ky/aQ4myhSZPAUJ5+8ASimpve3sfFsWvgKKgIKdU
	 rvyqdiDJQJPVi1cB9g1JUjbJkHcsU0G48rpxL4jAdmI2y3QWLUPha0rmoTKeLBOq9G
	 FHDqlybfzqad67c8+pocvE/v9RiaviUa10tfewv96uxUBjLj63KCKJLcmdbwZz5/ae
	 1NfzZzC2a+NlqEoYU+uyefgmI5YaQXtI7/0ybe9G3bNm9xFzFxyxVf1yUSjSUZLKgk
	 XmMInzkYD9YXVAhuJjNxpk8DlxP9490N/9HuX2qigElgbdNhQIzRvwMdFvYQN7vekq
	 YmOSt8ZQYCOcg==
Message-ID: <8f511684-3952-4074-8d97-51f4789f3151@kernel.org>
Date: Thu, 22 May 2025 20:17:37 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1106321: iproute2: "ip monitor" fails with current trixie's
 linux kernel / iproute2 combination
Content-Language: en-US
To: Yuyang Huang <yuyanghuang@google.com>, Luca Boccassi <bluca@debian.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, 1106321@bugs.debian.org,
 Netdev <netdev@vger.kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?=
 <maze@google.com>
References: <174794271559.992.2895280719007840700.reportbug@localhost>
 <CAMw=ZnSsy3t+7uppThVVf2610iCTTSdg+YG5q9FEa=tBn_aLpw@mail.gmail.com>
 <f6475bd4-cf7e-4b96-8486-8c3d084679fc@kernel.org>
 <CAMw=ZnT7tcjC6z-9xuMbeC5RhDiaPRHaZB_2i_6WYNJ=cm1QVg@mail.gmail.com>
 <CADXeF1Hmuc2NoA=Dg1n_3Yi-2kzGNZQdotb4HJpE-0X9K9Qf5Q@mail.gmail.com>
 <CAMw=ZnTLuVjisLhD2nA094gOE2wkTLyr90Do0QidF5nHG_0k9g@mail.gmail.com>
 <CADXeF1HXAteCQZ6aA2TKEdsSD3-zJx+DA5nKhEzT9v0N64sFiA@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CADXeF1HXAteCQZ6aA2TKEdsSD3-zJx+DA5nKhEzT9v0N64sFiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/22/25 7:17 PM, Yuyang Huang wrote:
>> iproute2 is generally backward compatible with previous kernels yes,
> 
> Acked, will submit a patch ASAP.
> Could you advise which branch needs the fix?
> Is submitting to iproute2-next and iproute2 enough?
> 
>

Thank you for the quick response.

I should have caught the exit on lack of support for the feature, so
that is on me.

Please send a patch based on iproute2 main (though main and next are
practically the same right now).


