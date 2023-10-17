Return-Path: <netdev+bounces-41957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF8E7CC6EA
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 17:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC2E1C20A66
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 15:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339254446A;
	Tue, 17 Oct 2023 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="VHgF0XFW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CB7405C8
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 15:00:58 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356BA109
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8Dnwu8hddKeBCQN1AGuQhRYnhv34X8YogLYlORFaMfc=; b=VHgF0XFW0kZlHp3i3m/jTUgGI2
	/cPWG696rzgbLVnqCi/H9A6rLUZwousc2clIkipNd7goto3QVM5BUs81qh69RABpdVmGr6ERw55ma
	/7lFozn9tGmokrwbKvtxLSF9+lu9TYPJ2QVNcoQhY19pwKjbDoIJGqUDQqXVl2ltZFmbiT7gGNPH2
	s52jIwWw5YtrhuF43a1V5ViFbJgda+IGg6FhXJ3phA9uwFFXmbqT3oZfgc+eYVPSA/A4wOjdqVfNZ
	sA9Ecxunp+7cE0QP8XghObGeWB9HpRstkEcdlWSND+NEeIo4u682eR6XamsKcMGgN9ij7Ddmw5lfW
	RyW+IVEQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qslYy-000Gm1-3i; Tue, 17 Oct 2023 17:00:52 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qslYx-000IHA-7s; Tue, 17 Oct 2023 17:00:51 +0200
Subject: Re: [PATCH v7 net-next 00/18] Introducing P4TC
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, anjali.singhai@intel.com,
 namrata.limaye@intel.com, deb.chatterjee@intel.com,
 john.andy.fingerhut@intel.com, dan.daly@intel.com, Vipin.Jain@amd.com,
 tom@sipanda.io, mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
 tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com,
 mattyk@nvidia.com
References: <20231016093549.181952-1-jhs@mojatatu.com>
 <20231016131506.71ad76f5@kernel.org>
 <CAM0EoM=nT2KQcVqPrWvKJXnW7h8uodhu0daNsLkuAUt5n=zuZw@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9246d8a0-113a-9c71-9e44-090b6850a143@iogearbox.net>
Date: Tue, 17 Oct 2023 17:00:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM0EoM=nT2KQcVqPrWvKJXnW7h8uodhu0daNsLkuAUt5n=zuZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27064/Tue Oct 17 10:11:10 2023)
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/16/23 10:38 PM, Jamal Hadi Salim wrote:
> On Mon, Oct 16, 2023 at 4:15 PM Jakub Kicinski <kuba@kernel.org> wrote:
[...]
>> FWIW please do not post another version this week (not that I think
>> that you would do that, but better safe than sorry. Last week the patch
>> bombs pushed the shared infra 24h+ behind the list..)
> 
> Not intending to.

Given bpf & kfuncs, please also Cc bpf@vger.kernel.org on future revisions
as not everyone on bpf list is subscribed to netdev.

