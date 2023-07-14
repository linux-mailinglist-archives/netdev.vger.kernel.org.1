Return-Path: <netdev+bounces-18016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1050B7542C4
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 20:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF901C21614
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA6C15AD2;
	Fri, 14 Jul 2023 18:45:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038F13715
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 18:45:34 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.17.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CDA358C;
	Fri, 14 Jul 2023 11:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689360305; x=1689965105; i=markus.elfring@web.de;
 bh=35bIn6dQKEnxNQuL73nFIg5EYYLtY7QXPxO+n/wjS1c=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=CEFbsB0ozncpXGMJuXW27LXhkRaC3wkvkPcuLNPqMklF40UTcDG1Eus5silVjS+fsgsbsSp
 Hzh2qVVkirt560PuculrWjcagdfNqM1DB20NhePNN4qjGy/OXWCrjZhNnW6kYMc56yfWPFzpf
 qF31O0Xv7tz6J+ZR3+9uekt8r/DzdhsTvsuvdSH5lzQhSA/jyO5dXdkDCo6dHouuObfRKfP1H
 o5m9/y+//YADPXJVAYhQdNQo6H8898JzvVukWYCgozJCzhH2VpAqkTA6ynvdDymanzM8n1Vnu
 YVOiFhnCCuTwXTi2TPpHlu+TO2vCM/b83wasObHg9w4ctirHzY8A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MT7WH-1qWrSY0GD9-00Ujd9; Fri, 14
 Jul 2023 20:45:05 +0200
Message-ID: <d36c1801-a217-519d-0bcc-7716cb16360a@web.de>
Date: Fri, 14 Jul 2023 20:45:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Jay Vosburgh <jay.vosburgh@canonical.com>, Wang Ming <machel@vivo.com>,
 opensource.kernel@vivo.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Minjie Du <duminjie@vivo.com>,
 Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek <andy@greyhouse.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <3370.1689351142@famine>
Subject: Re: [PATCH net v2] net: bonding: Remove error checking for
 debugfs_create_dir()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <3370.1689351142@famine>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YBjc0RCTckXT0sYJjD17bbd/LxuJ4BZyvVPGTHkxCGpXSk4dN8z
 fip0OHlKph3LNTwj9FZvq5KmvmWArXOiZMy6f4h48R1ltbKWwy8w3I+epgmmyOfRoljJGU3
 4Yl9veMopoX9kNhzyGkMNHxfMWOYQbslFXIgmYWl0G9JQvkqrw04HpoUGJASR2yfuSF3x1X
 9U/vduzWh1Y64IU+OTMzQ==
UI-OutboundReport: notjunk:1;M01:P0:7pzcBBsfB9Y=;LVBY9XvHmwzyimk1zhwj6w1EMqq
 JfpPfgeta0R+yp0efrFVbuNcBjUsAYq7CyKTduMy5e9y0rZmSSXYRnt7vBV5hQibuB8itWBmj
 BY5UsEqf3ZKxjo7eZ2imiP9Ro6iGjQ42oiTyzUYPjwe0+BxGdWK9pK7Wi0spl0PsXAzoRzH9V
 aPJHnv4nrvu7s+4970zdCLnBBhEGsKPRyo1iXgvIqdnbqjW6XkTAN7vtwQa/F6JPSOX3kliQ+
 hYleIN14i1W5HVuZEMRWWOO92ea70c31W32ItvdghFoSP7UtFjnAoqvBTCagHgoZSLzeQwGW4
 8JxzfqzBpOlZtDtm33QVbF1pwEghn8syjeqd7npyDdmqtYVFk2pgHfDs4zwTynxJHhkFunK7q
 02aBoxO+1NDclT3ElsC367tBuN9AnIKVF4pZC36jsZ3CX9tU5BWzWIvmqhF7tw8Qo8ozTvLx0
 ojj4pkeN49PDrKsRR+pnAeUutVQ9zDgKn7nM9Fdr10g8txnuWhrf6KxUxeAn4sXas5OP1fcGI
 EnEDcMT+NhwKfNY3CiFSKO5esToTXoZH2joLSk3X40TbjXqsStj+D/ywoJT6ZpRH0tS4oR53W
 8MwedCL5iK20QZ4FSuCrqTJSMXyAja5gfX7VjWr//JVuXKv2RUkO+tw2KHLrjBklkN8b00ILH
 qeliE/tvNrlK/5OsX9xJeemlvTBE2K1vmnkTRVsaegH8R+Uuex++Q5aYPFuMUPbQzMKqLlxfd
 AWreeJkJlJhlCeiizYRQR0CW/SSSCTvbsNCWa+SAfbYvzJ0IteekToE3pf1AlkxEYnZK60DTW
 R9drlmJbrIb7pKJtqBwxSYqjdCJSZ5Bw6R+sg8vx83H5znAavgT1usMoxHuhE1ZUtZUzn1iJG
 oUeKlFMOnpXUlh/LMaHu2cw6gkGyRkE0kgr/0CEzM399XbQssUB1SxlGjGQY36/SLxemDLzQL
 79Rhbw==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > It is expected that most callers should _ignore_ the errors
> > return by debugfs_create_dir() in bond_debug_reregister().
>
> 	Why should the error be ignored?  It's not a fatal error, in the
> sense that the bond itself should be unregistered, but I'm not sure why
> an error message that the debugfs registration failed is undesirable.

Would you like to insist on the possibility to get informed anyhow
about a bonding debugfs directory creation failure?
https://elixir.bootlin.com/linux/v6.5-rc1/source/drivers/net/bonding/bond_debugfs.c#L87


> 	Also, the code in question is in bond_create_debugfs(), not
> bond_debug_reregister().

Is it interesting how improvable change descriptions are presented?


>                           The diff below looks a bit odd in that the
> context line lists _reregister, but that's not the function being
> changed.

I do also not see the mentioned identifier in an update candidate.


> 	I thought the v1 patch was fine.

This change approach (from 2023-07-13) looked mostly appropriate.

[PATCH net v1] net:bonding:Fix error checking for debugfs_create_dir
https://lore.kernel.org/lkml/20230713033607.12804-1-machel@vivo.com/

Will the review attention grow for any remaining concerns or ideas?

Regards,
Markus

