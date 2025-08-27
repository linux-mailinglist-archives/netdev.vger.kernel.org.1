Return-Path: <netdev+bounces-217376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73757B38800
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD1F685802
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9543279DAC;
	Wed, 27 Aug 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwd33EBe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0230171CD;
	Wed, 27 Aug 2025 16:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313324; cv=none; b=lGJAoWBXc8MC2g1fWsve7mU25ewZzCv1Ah110qyvHtP3aNuhP3fB5Kn0yXi+ZNhd+2hDk8oFnmxTnTCMZZreA8qWlvwaMoNi9QRS3GzRLEIHOpd0wqf4sOX4nf63adHrvmYaX03mNl0lU1uaX1Wxu3Oj4P7vc57ddlGmB0ZmeCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313324; c=relaxed/simple;
	bh=T627dQnFkbXkLSa5363HBXG3v1Jx049xWiEkuFEady0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RJYw0g0CCDzI6vtDlRcXDdd5sz4heujrZAwRM/kdz3CwurhEz1JBKxaqsjt0KDa/zb/sPj0w/7ma7nIcDrGrvI/nulu1RSpw3t57Fq3FSQ0C7y/CWz+zO977Fon2J7NolR7zClQSBndJK+pV0iG3bcgc6DYCZkJU0HeXol+ne6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwd33EBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D978AC4CEEB;
	Wed, 27 Aug 2025 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756313324;
	bh=T627dQnFkbXkLSa5363HBXG3v1Jx049xWiEkuFEady0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nwd33EBexB2Slm97ViVSM4LLt4exgGG0qfjVPGdEUvWYxKImQT8Aany8EolhkF2DI
	 VfNFp9gHe6X3YJK+y8JvMwxf7Jtn78HLttnojga+/K7hDDtHYl1alhxJF5EzEIULwG
	 zQoM6IZifTEVcNNd7yHYq06404jCvRU1GBb2DCuchImnW5/lDDMPXSA3wV9twkpyHe
	 vz4NqYt5h8JnfVXo/rUasH/9SE+UdYvJj1VXKigI9dkQOPobVnKLFAVyU4iLzYk0t5
	 pCHBttbs2z+wTu/4O28sf6b55S/9TP6kgLtue/okeT0yJuTaqKAz9BmYbqpU5vYSjv
	 m9PSMDXxjq3RA==
Message-ID: <5cf568ac801b967365679737774a6c59475fd594.camel@kernel.org>
Subject: Re: [PATCH v17 00/22] Type2 device basic support
From: PJ Waskiewicz <ppwaskie@kernel.org>
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org, 
	netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, 	dave.jiang@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
Date: Wed, 27 Aug 2025 09:48:43 -0700
In-Reply-To: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-24 at 15:13 +0100, alejandro.lucero-palau@amd.com
wrote:

Hi Alejandro,

> From: Alejandro Lucero <alucerop@amd.com>
>=20
> v17 changes: (Dan Williams review)
> =C2=A0- use devm for cxl_dev_state allocation
> =C2=A0- using current cxl struct for checking capability registers found
> by
> =C2=A0=C2=A0 the driver.
> =C2=A0- simplify dpa initialization without a mailbox not supporting pmem
> =C2=A0- add cxl_acquire_endpoint for protection during initialization
> =C2=A0- add callback/action to cxl_create_region for a driver notified
> about cxl
> =C2=A0=C2=A0 core kernel modules removal.
> =C2=A0- add sfc function to disable CXL-based PIO buffers if such a
> callback
> =C2=A0=C2=A0 is invoked.
> =C2=A0- Always manage a Type2 created region as private not allowing DAX.
>=20

I've been following the patches here since your initial RFC.  What
platform are you testing these on out of curiosity?

I've tried pulling the v16 patches into my test environment, and on CXL
2.0 hosts that I have access to, the patches did not work when trying
to hook up a Type 2 device.  Most of it centered around many of the CXL
host registers you try poking not existing.  I do have CXL-capable BIOS
firmware on these hosts, but I'm questioning that either there's still
missing firmware, or the patches are trying to touch something that
doesn't exist.

I'm working on rebasing to the v17 patches to see if this resolves what
I'm seeing.  But it's a bit of a lift, so I figured I'd ask what you're
testing on before burning more time.

Eventually I'd like to either give a Tested-by or shoot back some
amended patches based on testing.  But I've not been able to get that
far yet...

Cheers,
-PJ

