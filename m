Return-Path: <netdev+bounces-17949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F97753BCB
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 15:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92BED281F65
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DE5749E;
	Fri, 14 Jul 2023 13:28:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A511373D
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 13:28:15 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BF230E6;
	Fri, 14 Jul 2023 06:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1689341264; x=1689946064; i=markus.elfring@web.de;
 bh=+XpP5TRy38bhJbTjRVvX6lgWm1c0r1++aJn5nSY64Ss=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=HzevYDjXjCb/zZs+quOQRfk4zlq3zUbn2O8i/HhKc5CQ/LIcIbFn3jB8BAwfOtDkC+MUBt6
 eisMCP539A8TT97FREmst4D02RMjMAYUqrrYH+NLllcwY01MWptkl+4CqSdY0gcg3Fie3o52Y
 w+rXGc++ggrc4bxQ1IxeuO1Me3oni/xsKmJB+Abom4UPxRXVUos8UIP2aQxJ6yornz9OOfbSH
 ka/i4fMFykehYmUZapH2UrciGxNLNXoAE6DPs737jObSkjPCxiqhUFtEYK3EA+j0TY/POevqm
 zCu7e8vZW9L5oQ2WcBEH8kOY7izwB1lhice8YpSjNAi1ZTkaiGKQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MNwjc-1qZdpP3pyS-00Odqw; Fri, 14
 Jul 2023 15:27:43 +0200
Message-ID: <455d6ba8-07c3-f3d7-7dd7-9e3242549da2@web.de>
Date: Fri, 14 Jul 2023 15:27:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Wang Ming <machel@vivo.com>, opensource.kernel@vivo.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Guangbin Huang <huangguangbin2@huawei.com>, Jakub Kicinski
 <kuba@kernel.org>, Jay Vosburgh <j.vosburgh@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Yufeng Mo <moyufeng@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Minjie Du <duminjie@vivo.com>,
 Jay Vosburgh <jay.vosburgh@canonical.com>
References: <20230714090856.11571-1-machel@vivo.com>
Subject: Re: [PATCH net v2] net: bonding: Remove error checking for
 debugfs_create_dir()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230714090856.11571-1-machel@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QVKhOvO5+NEX9JYcERStjf6wFcD2ShATuQpkXaLj9fG0k5RqgHW
 U+oXEv5RlxjPCNAazAEVWGsPvdS6AOEaWWC8EFU3N1PZ8YYCNe+Fhi80C5U7hXe7t9JZ5oV
 3gpcVjdUyECahtt9gXOP29C4LdLVAQcfNUZZztlqhPaPjdnC4ymCTJI6D2CetbynwykjzW7
 Kdhr+EmLJi+bZ/EW+zuLA==
UI-OutboundReport: notjunk:1;M01:P0:Ozu10+b9cYQ=;VytCaP25Ebpqo7FYCGdZxycJ6CJ
 iYrvosxwyqos1gi80Hi0tFf8mCXY56J5RLWCckVjMVzM53BBfQhB9ld+EAWVxIPX5m3f1PoS3
 fsmS+1W7nMaTG5e2NN2p8Oa5hFZLjVRxy0GTu9gmnWq+aHoADo1SkHUS09mXnd+KWqN6l1+gM
 VfHYfAeXo3+GPgTjUbhAzyx8Cvstcqid640JIDS5FYKjdw/+qHindf26+gk5dgxfd3xG32oqG
 o40DDDXnCv0+LWEjvAEt3TZUCg1USpb5Zb5xgMcfVR4Eu9ync3X7N5bXcAw91WmX60WHiOCQU
 EY/+FG82l7kSBytVZAMt7pYU5SEjCwDfSttAyaHSoFH1lOE1fIPiLbfP+PUJouVohJlCY4udt
 HAN955h76uFp8cufPleM7qSYtE0ij/bPHeFOmpY1m1nkngrAEjHLtp0nLlgFfM0W/W/VhuWDX
 kjyVJmtpNANPWWlB21V2V+Vuqy9RCYYsG0hK3VDvGDnuPUqMxxEBLh7Gv0Ue1RfHQCIDGFYji
 tBjvt8kIcqYhpN69Wmikwjgp0EJ6Af4Zybnawd4ks/6CL/48OAi8ugpfB7wFib9ylUaBySVcP
 2ciLM8rNSWlsfwaSvAFmYx/mdC4SZgUGmfIC/to+XmhjZ3oYEo0597MNq2WvuzFHFW7+sZ7HT
 464+8J7qs6Xm5jvbZ95BsidNREzONmNFYm3h2567BVYJ73Ztd4X0Ox6NBxCtBuIOiuIVK3+KT
 jeV90deoaDHhEOCLJsBpHj4CuFE91A1BhUau6FXxy5SiAIuRRqaBG/OizAigRSnQSAOxH1OMm
 rxzjwi2j9jWIfx43W1k6Go2RT8NK8B3X+kufHXPrWmzIqIOQxwalEZ4TzlxCenmVwBnciwo/M
 uuJgdaROnABNT9wdmso7RPV07UuSt6YJdyWlouCDfAVnR62zWeLNrbPUUyM11x9B1APoelBqI
 foEUCA==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> It is expected that most callers should _ignore_ the errors
> return by debugfs_create_dir() in bond_debug_reregister().

Did you overlook any patch review comments once more anyhow?

Regards,
Markus

