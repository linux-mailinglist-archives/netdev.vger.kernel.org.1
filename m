Return-Path: <netdev+bounces-54815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C6880858B
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 11:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02911F225FA
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 10:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32692341B9;
	Thu,  7 Dec 2023 10:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oSqwEHm4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A73AA
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 02:32:21 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so77932966b.1
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 02:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701945140; x=1702549940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IJ/0wt8MENOfl1w1xBZ6ccivlQS7h53f7MZwnMr4KGM=;
        b=oSqwEHm4EWqGGd7BZsKL3maqp0li4gN6T7kc8JoYdyk77LMuNyTq6/gWzd9pWdGhhK
         zloFbdczyb/jVVh6+EJO86ZAu6qp5vMXpRyZsJ/240wDBtY7W0XAcPhk/Xcyrdi8f5gl
         Y5wmlM2lbEf0APLpOBDGlh9vwIRq17YPheKno8WpiCIVEvk5OwSbkFp5rWZgQUdz7oRr
         SKzsTVypjKCbuaAC2IdhmUSR8JsMstgTgA9eDBB2c/ZtzNXLjgwG2GZkvfFFk2h6zUZ5
         kSB6NJFSYOiZ9cUGmzKnZpRY43q3hdBWv4zE20i67zMPE3SWuT8l1ASTyxsvX3Qlq3iu
         9AGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701945140; x=1702549940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ/0wt8MENOfl1w1xBZ6ccivlQS7h53f7MZwnMr4KGM=;
        b=momzMiJ1BRJy7ncjDrxk4IzfYP24jgbLpt1usQwgYP1UAIhr+BYa2vga/vhUTkHYoR
         z0WQqsvzGjI47Z2/nXlk5Bzg4ZkrsfXAFLgmEvHXsN/8iUYk2RBZh7udRUretWfqUx1d
         wxHWUhH/7O4ccc2SyOiLpsSjtQ0JGvQibeCAHwXnnJ9oVTBT1C6t5b1sHVEYzVIFxBnu
         f6UlztKjuSZa2Oihon42jsQHeo/mbdMvSdURGNQwRwP21BNs3iA0yQUwkoqHg3tx0vHU
         xJYOZSCb48fdfZR+qZ0aMZfqJqOqFW9Fpzq8UCUJNr4IZdsK/6RR6jz2nWUSNs2jcqgX
         DkEQ==
X-Gm-Message-State: AOJu0YzRf9lnnrXczHQg/eX+SSjBNiiDqeWSfgdzUWMIOF6bU28M9z4N
	qGTLPcS6EVjpMclL8ewVD33yBg==
X-Google-Smtp-Source: AGHT+IGVJtlPHwhJvX/bBnwM3LsbyZ1odIdLh4i7OMf8ZSsNx11yVpV24PwNU1Zp9HRkNf2wNTnllg==
X-Received: by 2002:a17:907:cc1c:b0:a19:a19a:ea9c with SMTP id uo28-20020a170907cc1c00b00a19a19aea9cmr1237451ejc.85.1701945139750;
        Thu, 07 Dec 2023 02:32:19 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k19-20020a170906681300b009a193a5acffsm636262ejr.121.2023.12.07.02.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 02:32:19 -0800 (PST)
Date: Thu, 7 Dec 2023 11:32:18 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, nhorman@tuxdriver.com, yotam.gi@gmail.com,
	johannes@sipsolutions.net, jacob.e.keller@intel.com,
	horms@kernel.org, andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH net 1/2] psample: Require 'CAP_NET_ADMIN' when joining
 "packets" group
Message-ID: <ZXGfMncXs/sqF7XJ@nanopsycho>
References: <20231206213102.1824398-1-idosch@nvidia.com>
 <20231206213102.1824398-2-idosch@nvidia.com>
 <CAM0EoMmPEQ5nETLt8OkADQR+ACgHCOShp6gEA1DK+jR7mK-gNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmPEQ5nETLt8OkADQR+ACgHCOShp6gEA1DK+jR7mK-gNA@mail.gmail.com>

Thu, Dec 07, 2023 at 11:16:30AM CET, jhs@mojatatu.com wrote:
>On Wed, Dec 6, 2023 at 4:33 PM Ido Schimmel <idosch@nvidia.com> wrote:
>>
>> The "psample" generic netlink family notifies sampled packets over the
>> "packets" multicast group. This is problematic since by default generic
>> netlink allows non-root users to listen to these notifications.
>>
>> Fix by marking the group with the 'GENL_UNS_ADMIN_PERM' flag. This will
>> prevent non-root users or root without the 'CAP_NET_ADMIN' capability
>> (in the user namespace owning the network namespace) from joining the
>> group.
>>
>
>Out of curiosity, shouldnt reading/getting also be disallowed then?

This is about the sampled packets. You only get them by notifications.


>Traditionally both listening and reading has been allowed without root
>for most netlink endpoints...
>IOW, if i cant listen but am able to dump, isnt whatever "security
>hole" still in play even after this change?
>
>cheers,
>jamal
>
>
>
>> Tested using [1].
>>
>> Before:
>>
>>  # capsh -- -c ./psample_repo
>>  # capsh --drop=cap_net_admin -- -c ./psample_repo
>>
>> After:
>>
>>  # capsh -- -c ./psample_repo
>>  # capsh --drop=cap_net_admin -- -c ./psample_repo
>>  Failed to join "packets" multicast group
>>
>> [1]
>>  $ cat psample.c
>>  #include <stdio.h>
>>  #include <netlink/genl/ctrl.h>
>>  #include <netlink/genl/genl.h>
>>  #include <netlink/socket.h>
>>
>>  int join_grp(struct nl_sock *sk, const char *grp_name)
>>  {
>>         int grp, err;
>>
>>         grp = genl_ctrl_resolve_grp(sk, "psample", grp_name);
>>         if (grp < 0) {
>>                 fprintf(stderr, "Failed to resolve \"%s\" multicast group\n",
>>                         grp_name);
>>                 return grp;
>>         }
>>
>>         err = nl_socket_add_memberships(sk, grp, NFNLGRP_NONE);
>>         if (err) {
>>                 fprintf(stderr, "Failed to join \"%s\" multicast group\n",
>>                         grp_name);
>>                 return err;
>>         }
>>
>>         return 0;
>>  }
>>
>>  int main(int argc, char **argv)
>>  {
>>         struct nl_sock *sk;
>>         int err;
>>
>>         sk = nl_socket_alloc();
>>         if (!sk) {
>>                 fprintf(stderr, "Failed to allocate socket\n");
>>                 return -1;
>>         }
>>
>>         err = genl_connect(sk);
>>         if (err) {
>>                 fprintf(stderr, "Failed to connect socket\n");
>>                 return err;
>>         }
>>
>>         err = join_grp(sk, "config");
>>         if (err)
>>                 return err;
>>
>>         err = join_grp(sk, "packets");
>>         if (err)
>>                 return err;
>>
>>         return 0;
>>  }
>>  $ gcc -I/usr/include/libnl3 -lnl-3 -lnl-genl-3 -o psample_repo psample.c
>>
>> Fixes: 6ae0a6286171 ("net: Introduce psample, a new genetlink channel for packet sampling")
>> Reported-by: "The UK's National Cyber Security Centre (NCSC)" <security@ncsc.gov.uk>
>> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>> ---
>>  net/psample/psample.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/psample/psample.c b/net/psample/psample.c
>> index 81a794e36f53..c34e902855db 100644
>> --- a/net/psample/psample.c
>> +++ b/net/psample/psample.c
>> @@ -31,7 +31,8 @@ enum psample_nl_multicast_groups {
>>
>>  static const struct genl_multicast_group psample_nl_mcgrps[] = {
>>         [PSAMPLE_NL_MCGRP_CONFIG] = { .name = PSAMPLE_NL_MCGRP_CONFIG_NAME },
>> -       [PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME },
>> +       [PSAMPLE_NL_MCGRP_SAMPLE] = { .name = PSAMPLE_NL_MCGRP_SAMPLE_NAME,
>> +                                     .flags = GENL_UNS_ADMIN_PERM },
>>  };
>>
>>  static struct genl_family psample_nl_family __ro_after_init;
>> --
>> 2.40.1
>>

