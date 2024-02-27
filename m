Return-Path: <netdev+bounces-75349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298F086998D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 16:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C5C1C22A67
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E9113B2B4;
	Tue, 27 Feb 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FiB2zrn9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6813AA37
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045776; cv=none; b=H1Go4yxzZgUZuaiQCoxAsPg7dqP4jc2bpyv7EtdWiwPMXjbquiCDwfVT7wiG18GMPEL0QH5eRi8NZOoMcBXDVpn4foQJ1IykSCYCX/F/87aRem/Pn3jc88ULTGv7JMrcjDTTbXOyI61TIef9IMyI8VZSHIosvemxzcgO0/PYXkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045776; c=relaxed/simple;
	bh=/Vxj/t60ZInBvMOiKMbTcSU1kCJwHW9LP1RiQ82RfxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNxJ/2C6YkPJevymFRF9rnffAHTnGSZe0nIoQ4te5ZpJ5VxI3EA6aLNuYBI9I7+wP4XzpKtG43Dg5eh1WRZekSxovKQUmcT5QVjYTow1uLwu0NU+u/XvnWY++KMFQEDGC/ktN+/ETZXc5qT8UOI43HfNHnLVVmSZNyVoIqtgyMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FiB2zrn9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ECA6C433F1;
	Tue, 27 Feb 2024 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709045775;
	bh=/Vxj/t60ZInBvMOiKMbTcSU1kCJwHW9LP1RiQ82RfxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FiB2zrn9miPXkGzVtmsvBGXYWQ4BBtEES3rCtdWo1AVrnrXkt7a5hLg8VvTQQGj3m
	 5o2VFN+I8jjR1wne7k4HZOG8mnhfylEgW8jDPBBqsiGEprBRExcW5/L8IfL71pgT6f
	 vtTeyKq/io7Tm0vgCFj9YDN20kM2guZ2sM0PEIo57X7UEFAWTy83CkadIH/iQHvdE3
	 7DianHCz0cvEC9KZwzNKkKLhPA31FEJWcbwZxHgWMAvPdaXyRaZDm/TKHPpqjVSeJT
	 b85LU9EOYp/8Mw/gXr9qvKAs+LWp/C1i0BGMHx1xFQAiOkM5rQI47oFjy9gefShRa6
	 B/o78pf8APVTQ==
Date: Tue, 27 Feb 2024 06:56:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, jiri@resnulli.us,
 sdf@google.com
Subject: Re: [PATCH net-next v2 02/15] tools: ynl: create local attribute
 helpers
Message-ID: <20240227065614.57946760@kernel.org>
In-Reply-To: <8047ae8d-e2c0-4818-942d-2581ab56ad6d@6wind.com>
References: <20240226212021.1247379-1-kuba@kernel.org>
	<20240226212021.1247379-3-kuba@kernel.org>
	<8047ae8d-e2c0-4818-942d-2581ab56ad6d@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Feb 2024 12:05:31 +0100 Nicolas Dichtel wrote:
> > +static inline __s16 ynl_attr_get_s16(const struct nlattr *attr)
> > +{
> > +	__s16 tmp;
> > +
> > +	memcpy(&tmp, (unsigned char *)(attr + 1), sizeof(tmp));  
> The same would work here, am I wrong?
> return *(__s16 *)ynl_attr_data(attr);
> 
> Same for all kind of int.

What about unaligned access?

