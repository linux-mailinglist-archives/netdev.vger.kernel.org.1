Return-Path: <netdev+bounces-22015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89238765B46
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 20:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520471C215C7
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 18:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D368174FC;
	Thu, 27 Jul 2023 18:16:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DA2714D
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 18:16:53 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FCDB30F4;
	Thu, 27 Jul 2023 11:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690481799; x=1691086599; i=markus.elfring@web.de;
 bh=CxkQJ1stnzNdyF4QHtcdx188k1ivSXTpG4qq4g3rzTE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=VBljIjkjtHo2q3FDMtT1JCp0NLXnmU9q+Rs9r9SGoKMMPvWakWD5TsnWEwiAvjsxjRBy95y
 T/Qx2PZsRgHlMF5zqgRJhifN6OQRcX2zKZ/AWYT9vudiuOMOeS4WlB8ZqVI3pOdZJ+VlcypdG
 wcfRmyCidJ8MUXVgzQ9zGVtc4hLzLR155zQXy8LYHqDDho0Jqmvn7dLRD5gYqXKswcE2KJkmf
 vkjG/MF+s1k5/72keYKe1X+p+tu3/s54B4QIlMNGmLOv9189z/Lw8/X1Wg42Z55rXAEyoBcwO
 0CiRV1N4qbldCE8CPQc+8uVvmcJofp/X2yDEeH8w2fcUCet9S7+w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPaII-1qBORY3jFK-00MgIE; Thu, 27
 Jul 2023 20:16:38 +0200
Message-ID: <d1cc3520-4494-5c3b-e9d5-55e406831430@web.de>
Date: Thu, 27 Jul 2023 20:16:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH next] net: ethernet: slicoss: remove redundant increment
 of pointer data
To: "Colin King (gmail)" <colin.i.king@gmail.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Lino Sanfilippo <LinoSanfilippo@gmx.de>, Paolo Abeni <pabeni@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20230726164522.369206-1-colin.i.king@gmail.com>
 <662ebbd2-b780-167d-ce57-cde1af636399@web.de>
 <64213517-099b-e5a7-6cf3-2f78fa59ee99@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <64213517-099b-e5a7-6cf3-2f78fa59ee99@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yvRPEHSQmriPqKJSNd7HLmOs64puIKBBD9/PXV5xGdgP6A4QFaW
 2V2zMepDZXp/tl3/CCoQXt4eNFvA7myQXY7wwNgWQodtU+Wv+rqVxejHFSMNN9EQib2Lrzk
 I5JCJzd/K8IgdmCSvioMeLlPpLAf/+wW+Re8ocMiCZBFGC891wHjag26x72EoKJSGvzIjFG
 6tl985IEvYHE1lL4hXLmQ==
UI-OutboundReport: notjunk:1;M01:P0:RwHozxOlvZw=;ZYkbfBM2mWW/72x+6CM37ebej4A
 gC1VlMuC+oyAcXIN8w9Q6ImovSCsXl4VZCdhVjBmZBR8SidqkZuDDZuCDtkosPa4krxdcBbbJ
 sSlps/u1SBmcErNT8EeTpftIO81nNGvvKYVxmzPU0C6cS+ZRNJ8JvFko/xt8f386tGb8ngwzM
 2i20/RcM91BE4xqTE7H1Blso35mF9qJ7iGesko2iW7GMFlSsDDBENAYJ5Xa4L/1Z6tytcUGrp
 KvnA1IsRHuJXurCOmB+dm6WMqOtDfB9/0TCmqO5J6Q8pYCFY29lY5J0LqijSDlt9ah6Rtauo2
 g3pqgqsPfPsFv2blylv91B3z18HLrO1KwGYJmi5QIBrwDLhLUGe7Wqrfn4aVXD/3CJ0XrfFm/
 TmHAl2EewJZ6bQHGPqRZOsghwYvwPxi0O/FKrcw2IS4HYoXYZKjnmHyvBrCXMrVA+ewMqYosU
 KsZDTy2ZdY3BCd7bi46RmQ8jAp9WOH6x+Qfze9y+phNII0Iarf3SR6O+5ACELXPjche1GXvOB
 x0ib7LyA32oysgReJqe7CjBgj5xkdUOSN9g1KR/HQZg6ErZoIP/Z/RUVwxe7EaIo07PS5HDGE
 iqaae+xUPweoEAQTKO1I2U/Wa5cnuA/b2oWf/MZ/RDFIKLMU99BlUd7Pl9h6RZYF/EzKylj2D
 9M7AiWWamd8GI9wkIOq3RoIeCADuMSdAbfkaO8ybwEXiZ93afSH7yNyFlW9BgLWgO7OkJoEcq
 ajTQOAiMurMZwFE3pluxovl+QjSawXOwkG5hKMlTjJcw99eGiwYujUzM17W84T6E5vZLeLRjj
 RC/XUo2q6gbtWlS2vdD2YlMYPfUAlG/WqOuvGYDA819MWiuWJfi2g7bIl4jjfTfD25UPFga5a
 TQg4/5DwpwUyWMYftf4ICKG2i1ANhtxSff4zBxEoT7EayTkE9gbfWMIqpp9heEz76KKVIK3JJ
 B44meA==
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>>> The pointer data is being incremented but this change to the pointer
>>> is not used afterwards. The increment is redundant and can be removed.
>>
>> Are imperative change descriptions still preferred?
>
> Hrm, I've used this style of commit message for a few thousand commits, =
I hope it's still fine.
>
>> See also:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.5-rc3#n94

Will the attention grow anyhow for the desired =E2=80=9Cimperative mood=E2=
=80=9D?

Regards,
Markus

