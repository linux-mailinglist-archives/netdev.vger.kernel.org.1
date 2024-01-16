Return-Path: <netdev+bounces-63764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9B482F4EE
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 20:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793CC285B8B
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 19:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9701CF9C;
	Tue, 16 Jan 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="a4G5Slez"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5E1D528
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431818; cv=none; b=uSyuf047uDLRUDHjrFVdQpaiY31xJFYRhMtQ3grDjYVP/HPdSen3y0u8CIURste+eh/06Sy8C4RDjGGKosWx6CfxYj2fJSqMyTsvf2i/EvR0BDKVWxFSfy8xoO+7oEZm3UWAIkQIChoIIvwFJLMX9RDSZrTDsSAGeqBP1dBdJfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431818; c=relaxed/simple;
	bh=kXZnYT9M6pTQ/ff22VKcp9VBS+k+qXH8xX9DJMQcTSw=;
	h=Received:DKIM-Signature:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:X-Google-Smtp-Source:X-Received:
	 Received:Received:Received:From:To:cc:Subject:In-reply-to:
	 References:Comments:X-Mailer:MIME-Version:Content-Type:Content-ID:
	 Content-Transfer-Encoding:Date:Message-ID; b=LLsgFMeUtiLcdCZyaDPxYr476UulkcK/SBJF7nXU0dB54aZVFjnY+ziRnGm4rd58EK9RW75/wCTckDRxSSx806zOYNNv4HtRlKaetjURvDJKZXZXGKDKKuihqZCqH811+f0WaABpUQYr3wqqKEwXWIxwNyAl63M1Tjh9YdxuVVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=a4G5Slez; arc=none smtp.client-ip=185.125.188.123
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C1E663F275
	for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 19:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705431813;
	bh=h7Iqqen34z6UAzyzO0LtKXTf2uJ2NqVH/f9Nna3tT0s=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID;
	b=a4G5SlezbjAV7/FmRCu7JlGunXeip+Kw9KJ+MxME/Wgptcw4ufiukElCGurJuQ+O7
	 3QdlFwT1tG5EgeTdZJCorhEF8ORS+9l1+8ZHngB41NmbZkDOGsngGxXvPi8dfbykJT
	 7JCBXPv9XT0vHfUK8ibw+mhZQczKS+jxt6xF+KgZekLzi2XvawIATXTdZMrEwo/EO6
	 i/RvlEAwlcFrCVVMkDe975mESG3/YiAml/JBH9qOKMfJKnjLNoupF784D4wjh7If7u
	 VdrQKVfg2T7Gh6sCtEIvqCYKh3eZCXBIIsC3VDpghbuYaJVkSPYUO+nKGSbZw7lXBm
	 V0vGr1QhSw8iw==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28c5c622a3cso6634310a91.0
        for <netdev@vger.kernel.org>; Tue, 16 Jan 2024 11:03:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431812; x=1706036612;
        h=message-id:date:content-transfer-encoding:content-id:mime-version
         :comments:references:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7Iqqen34z6UAzyzO0LtKXTf2uJ2NqVH/f9Nna3tT0s=;
        b=ioLrQkhBuRJL8CT5LAsrsGXidEB87jRKJ3+ZSOoFGgjTh4JMNslVE1mpjnjIniFkFz
         MNtevaujXszOASzKbcp3hfKKvrZKxln1Cv0mEW0Gk1xD//ejtd1iC6ZX8dfJa+hy2ynx
         a1kYrvM+Esbl1mR7kkGnFocF9Sh3Nvl3wsQWwTNfTpu9Y+jedcyaZmZo5xQTLmzz+aEN
         9VYx5e2228OqylqWkh/3kk6sBTQlQLhYrYzM7TLmazc6BGia+8Uf5fMMhCSkOsMY2PZl
         T9Rmt4Cx+IFZerTR42lQXmCoSKJFOmwTFpbGTzK6w2aXENLHRFTsXr/xffux2GWRanIh
         54nA==
X-Gm-Message-State: AOJu0YxaC78G351raA8cFtWFdUD3PtKVFzV2I1QYJXX6ygFLGrjVy39K
	PVwEIZMaB/VpdUx6blMGknNdqRogP09ZJfTBIItzB1WJBd+y0p3qBszEx1bPoXijSTZaRA/BVBh
	aZKDUGzARygCZpaSf5O8rVFLyDxE+sR+SqPh/IaDU
X-Received: by 2002:a17:90a:da03:b0:28e:778:2d6f with SMTP id e3-20020a17090ada0300b0028e07782d6fmr3655410pjv.61.1705431812148;
        Tue, 16 Jan 2024 11:03:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyMzLYVzlxwbri+kkV0gv6IcCE1p132lzgl7dLhWQYQQbs4xeeHBqdmZsW4mJReftjAzU72A==
X-Received: by 2002:a17:90a:da03:b0:28e:778:2d6f with SMTP id e3-20020a17090ada0300b0028e07782d6fmr3655398pjv.61.1705431811832;
        Tue, 16 Jan 2024 11:03:31 -0800 (PST)
Received: from vermin.localdomain ([209.121.128.189])
        by smtp.gmail.com with ESMTPSA id jy11-20020a17090342cb00b001d5e1353693sm1787423plb.266.2024.01.16.11.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 11:03:31 -0800 (PST)
Received: by vermin.localdomain (Postfix, from userid 1000)
	id B93EF1C3BB8; Tue, 16 Jan 2024 11:03:30 -0800 (PST)
Received: from vermin (localhost [127.0.0.1])
	by vermin.localdomain (Postfix) with ESMTP id B73711C3BB7;
	Tue, 16 Jan 2024 11:03:30 -0800 (PST)
From: Jay Vosburgh <jay.vosburgh@canonical.com>
To: Jakub Kicinski <kuba@kernel.org>
cc: Benjamin Poirier <bpoirier@nvidia.com>,
    Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
    Andy Gospodarek <andy@greyhouse.net>, Shuah Khan <shuah@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Jonathan Toppins <jon.toppins+linux@gmail.com>,
    Nikolay Aleksandrov <razor@blackwall.org>,
    Michal Kubiak <michal.kubiak@intel.com>,
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: bonding: Add more missing config options
In-reply-to: <20240116104402.1203850a@kernel.org>
References: <20240116154926.202164-1-bpoirier@nvidia.com> <20240116104402.1203850a@kernel.org>
Comments: In-reply-to Jakub Kicinski <kuba@kernel.org>
   message dated "Tue, 16 Jan 2024 10:44:02 -0800."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; Emacs 29.0.50
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78105.1705431810.1@vermin>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jan 2024 11:03:30 -0800
Message-ID: <78106.1705431810@vermin>

Jakub Kicinski <kuba@kernel.org> wrote:

>On Tue, 16 Jan 2024 10:49:26 -0500 Benjamin Poirier wrote:
>> As a followup to commit 03fb8565c880 ("selftests: bonding: add missing
>> build configs"), add more networking-specific config options which are
>> needed for bonding tests.
>> =

>> For testing, I used the minimal config generated by virtme-ng and I add=
ed
>> the options in the config file. All bonding tests passed.
>> =

>> Fixes: bbb774d921e2 ("net: Add tests for bonding and team address list =
management") # for ipv6
>> Fixes: 6cbe791c0f4e ("kselftest: bonding: add num_grat_arp test") # for=
 tc options
>> Fixes: 222c94ec0ad4 ("selftests: bonding: add tests for ether type chan=
ges") # for nlmon
>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
>
>With this applied the only remaining bonding test which fails in our CI
>is bond-options [1], good progress! :) Looks like it doesn't finish in
>time:
>
>not ok 7 selftests: drivers/net/bonding: bond_options.sh # TIMEOUT 120 se=
conds
>
>The tests run in a VM without HW virtualization support. Any opinions
>about bumping the timeout for bonding? If we enable KASAN etc. things
>will get even slower.

	Reading the grat_arp test, it looks like it has long sleep times
built into it:

garp_test()
{
[...]
	exp_num=3D$(echo "${param}" | cut -f6 -d ' ')
	sleep $((exp_num + 2))

num_grat_arp()
{
	local val
	for val in 10 20 30 50; do
		garp_test "mode active-backup miimon 100 num_grat_arp $val peer_notify_d=
elay 1000"

	If I'm reading it right, this will sleep for 12, 22, 32 and 52
seconds for the passes through the loop in num_grat_arp(), so that would
be 118 seconds just for that.

	-J

>[1]
>https://netdev-2.bots.linux.dev/vmksft-bonding/results/423800/7-bond-opti=
ons-sh

---
	-Jay Vosburgh, jay.vosburgh@canonical.com

