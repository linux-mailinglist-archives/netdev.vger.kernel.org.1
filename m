Return-Path: <netdev+bounces-153916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE23D9FA0D0
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 14:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD43167AF5
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 13:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD271F3D21;
	Sat, 21 Dec 2024 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="rbh5MGPc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D7b/Hv+X"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB52746C
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 13:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734788619; cv=none; b=SPRskhZf3ua+gWGdvaFHX9jBoehXDMS8PKn6CV4PYzkEsGTs18q5sVh56CRHbjD3cZfysYN7HimkfokBZQsjUmvxP42dc9xmlVxJj1K9EXMhJUrBg6EitmVrUQaJeq8Wrfatq1r2URA37OofoZgkJ3hV9X2M81Qug/CJJIo9XbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734788619; c=relaxed/simple;
	bh=E8q8HumIVUrz7k/PYiFplILTFsdRAUqek31XCDlyc+Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CJ4z+XpNTJ96I8dJQH1BEXNqxqZ9SDbWeI3be4HI0N0JAaj/aZpbUVhzAzFyXoQx1fYQNLUux8wWAPtJiNHlB1eYITQqYv3v4WjbR8IYE8lua7Wd9+ntEuzJQt6PlF2OoiDn8nopCkJpWGTplDwPLVFOD0nTm8VFiGW7YXGs25I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=rbh5MGPc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D7b/Hv+X; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A1C413801C7;
	Sat, 21 Dec 2024 08:43:35 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Sat, 21 Dec 2024 08:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734788615;
	 x=1734875015; bh=Slv2cA6xPTjIjg0ZfsJo8aeJ3139X0527tOb3Um81jI=; b=
	rbh5MGPc2RmZu4IaR80N6El/50cgoz4l5vvCuGA54SNoAM9a6+M+kccFgMDtr61R
	+iGOtpfgZjAVsp6Q2CoLuMbsywyP1xZI9W0Ln9VOqhM55pXVVcJa/v1wR/i4e6Bk
	WXgW37B2QruH7kxAFoAOmgC++HcUkzmF25NDwjsSSFi85AWMxIJx52Q8baBatXYn
	LF9HVoJfvpjLOCIIs5VxYSCrndbLpNHNONloc0bYJJ57ZIVYWUQokJNWkz4/i7vC
	kdlHG4Y2/37sTgW2bjV47B6nsTupwWop1cB6nMSRsZjH7zaP1Z1yWOpaBrtywO4v
	lac4WRh64UF/zTS9rZFBKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734788615; x=
	1734875015; bh=Slv2cA6xPTjIjg0ZfsJo8aeJ3139X0527tOb3Um81jI=; b=D
	7b/Hv+XZ4M+KQeRfnxdi8Plh+b7qTJji4o0lBvZfxLSrKiLK/U5GzILIVEzCqJi9
	ue+jsYo+Es2srtgtsAzAE58H0QakC+A4As0I/5S4B5G7okdPfaGrSrSVyUJTqj77
	ojf6WaUe76FJQ2DaAB53UEHXHM6oWG/isEn8GTXUL944DOocBEHY8B/aZ5BtBHdm
	oh8fp9fsXUulJWRWvuXigdotYOJl9QAuToI882afxzRSMCwVnLf99hOTN44HpHWo
	ZoIoqZr7Nl5mrO0ObFoBphRt2SpX1FLf4T+TNeiVM9NElSsoJyvoJ+tJiqxLRPcG
	D8lkbLge3UTU6bCZryUOw==
X-ME-Sender: <xms:B8ZmZwmnjzIiNvdHlUJ5fPAcRzZ-4HYrPgEwQRT0hTEdehWsvXuVRw>
    <xme:B8ZmZ_1QfqnVcZU_YM-E4VsedOsQWSVuJJDvh2ugD63kTb8LFufPt72vnM-0AanI6
    HnNTStNwXWOuNejtQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdeg
    jedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepohhushhtvghrsegtshdrshhtrghnfh
    horhgurdgvughupdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrg
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtgho
    mhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:B8ZmZ-ohKK57tTFGYVzLWbneICIIUjJmtpGp09wQNtyU1_Fac-QriQ>
    <xmx:B8ZmZ8kYKqoqL1Q3uqGyEsXDYUPylx62nzFy-jN9K7CtnT0wqNwicA>
    <xmx:B8ZmZ-3nwKkAT6EMb4hyJqup7Op1GacdIi5TQTUm-Ef1yIIFaRtIZw>
    <xmx:B8ZmZztK5GybbESJr-_b9E-E3b2E73XhyZC0eIOcwNWv4grnEewzLg>
    <xmx:B8ZmZ69_wSMO7TI0PKT1RyTCHdbmFhyhE19tUOdpoc5ivInTRMG11fG_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 106812220072; Sat, 21 Dec 2024 08:43:34 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 21 Dec 2024 14:43:13 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John Ousterhout" <ouster@cs.stanford.edu>
Cc: "Jakub Kicinski" <kuba@kernel.org>, Netdev <netdev@vger.kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Eric Dumazet" <edumazet@google.com>,
 "Simon Horman" <horms@kernel.org>
Message-Id: <728cebe2-6480-4b55-a6dd-858317810cff@app.fastmail.com>
In-Reply-To: 
 <CAGXJAmw6XpNoAt=tTPACsJVjPD+i9wwnouifk0ym5vDb-xf6MQ@mail.gmail.com>
References: <20241217000626.2958-1-ouster@cs.stanford.edu>
 <20241217000626.2958-2-ouster@cs.stanford.edu>
 <20241218174345.453907db@kernel.org>
 <CAGXJAmyGqMC=RC-X7T9U4DZ89K=VMpLc0=9MVX6ohs5doViZjg@mail.gmail.com>
 <20241219174109.198f7094@kernel.org>
 <CAGXJAmyW2Mnz1hwvTo7PKsXLVJO6dy_TK-ZtDW1E-Lrds6o+WA@mail.gmail.com>
 <20241220113150.26fc7b8f@kernel.org>
 <f1a91e78-8187-458e-942c-880b8792aa6d@app.fastmail.com>
 <CAGXJAmw6XpNoAt=tTPACsJVjPD+i9wwnouifk0ym5vDb-xf6MQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API for Homa
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2024, at 00:42, John Ousterhout wrote:
> On Fri, Dec 20, 2024 at 1:13=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>> Assuming this is actually meant as a persistent __user
>> pointer, I'm still unsure what this means if the socket is
>> available to more than one process, e.g. through a fork()
>> or explicit file descriptor passing, or if the original
>> process dies while there is still a transfer in progress.
>> I realize that there is a lot of information already out
>> there that I haven't all read, so this is probably explained
>> somewhere, but it would be nice to point to that documentation
>> somewhere near the code to clarify the corner cases.
>
> I hadn't considered this, but the buffering mechanism prevents the
> same socket from being shared across processes. I'm okay with that:
> I'm not sure that sharing between processes adds much value for Homa,
> and the performance benefit from the buffer mechanism is quite large.
> I will document this. Is there a way to prevent a socket from being
> shared across processes (e.g. can I set close-on-exec from within the
> kernel?) I don't think there is any risk to kernel integrity if the
> socket does end up shared; the worst that will happen is that the
> memory of one of the processes will get trashed because Homa will
> write to memory that isn't actually buffer space in that process.

It would definitely be nicer to ensure that it's only available
for a particular 'struct mm'. Setting O_CLOEXEC is probably not
be enough since this does not close the fd on a fork without exec,
and does not prevent the flag from being reset through fcntl().

Maybe see what io_uring() does to handle userspace pointers
here, I think the problem is quite similar there.

>> That probably also explains what type of memory the
>> __user buffer can point to, but I would like to make
>> sure that this has well-defined behavior e.g. if that
>> buffer is an mmap()ed file on NFS that was itself
>> mounted over a homa socket. Is there any guarantee that
>> this is either prohibited or is free of deadlocks and
>> recursion?
>
> Given the API incompatibilities between Homa and TCP, I don't think it
> is possible to have NFS mounted over a Homa socket. But you raise the
> issue of whether some kinds of addresses might not be suitable for
> Homa's buffer use this way. I don't know enough about the various
> possible kinds of memory to know what kinds of problems could occur.
> My assumption is that the buffer area will be a simple mmap()ed
> region. The only use Homa makes of the buffer address is to call
> import_ubuf with addresses in the buffer region, followed by
> skb_copy_datagram_iter with the resulting iov_iter.

Right, NFS was just an example, but there are other interesting
cases. You certainly have to deal with buffers in userspace
memory that are blocked indefinitely. Another interesting case
is memory that has additional constraints, e.g. the MMIO
space of a PCI device like a GPU, which may fault when writing
data into it, or which cannot be mapped into the DMA space
of a network device.

> Is there some way I can check the "kind" of memory behind the buffer
> pointer, so Homa could reject anything other than the simple case?

I don't think so. I still don't know what the exact constraints
are that you have here, but I suspect this would all be a lot
simpler if you could change the interface to not pass arbitrary
user addresses but instead have a single file descriptor that
backs the buffers, either by passing a tmpfs/hugetlbfs file into
the socket instead of a pointer, or by using mmap() on the
socket to map it into userspace like we do for packet sockets.

      Arnd

