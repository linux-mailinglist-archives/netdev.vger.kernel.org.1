Return-Path: <netdev+bounces-141286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA539BA595
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 14:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED501F213D3
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 13:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A614A167271;
	Sun,  3 Nov 2024 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ayrZ6uaD"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABE71E52D;
	Sun,  3 Nov 2024 13:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730639777; cv=none; b=rPbVaGsuN8EQhao3zF0u8uQ+LlNKnW4xTr03txJbhgMgs5RXYoxc696azrxTD0FSI4s6Lo2Mf6MPpmVl4OP0Y77SyyTwlbFZqNw3jLwTEHuYQLDwTZMKh3KL8dKUcw95ETKF+t9RbfTDfII5IGQCACP8LmVYW8zN/EBuG6a3lQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730639777; c=relaxed/simple;
	bh=J0bEm0YavRr3TS3jeCLxcn7Q8TAWoC2sGwksqFJ2bvc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jdeAqCoGt2YNIaePsYuaPKmRn+GYv95eZTxK70xXPMmDjG59HjSPJhdv9iejB4BHVl8PRI6m+cXfWo5dj1G2RpsRW4aM1gs78/1VM4e27uQxmRgjK6pO9OB335W2iKufeVcjYTOwgG9/90anOIL/68w8HEo1+8xdaI5UlzJlY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ayrZ6uaD; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1730639723; x=1731244523; i=markus.elfring@web.de;
	bh=GRfPwkl244f2VsYqHO3OSu1ULhSp0VlnY57ITD4BKl4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ayrZ6uaDSylyE+AY8rvbCZDy6Ww/t1YL2YPN3lwoHZpO7RkuCdqUGMdF0JXFiIVb
	 dU0Ij9zlyGzFfycqV/JgIryuFIm4yFPmTE5lCIUCOLWKmHvD5ZxTSwW+uBZEJnmTp
	 a61YEcksJ6x0jKOv2KXH7F5I1KVieXEwjHOp6R4w2Vm5Lb281ZbNqklYjzxqhHpxk
	 v64AolNxnnRNXsEosTjI0J1gFS/MYx8oKUq5SjWHhlUCnYN4faCLyBaGIY2nZhr+3
	 Lu0lyhDi1JYZ1LuDgH8drMF7zTd89tIJuX1JWBdE25mXS9pB/TidMrsC0Iw4lTg6i
	 5otSsbQDLhfPdAj4dA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqqTb-1tcCAU04q9-00aWmi; Sun, 03
 Nov 2024 14:15:23 +0100
Message-ID: <80516b25-a42d-48e1-bcf9-27efe58f44c6@web.de>
Date: Sun, 3 Nov 2024 14:15:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Juntong Deng <juntong.deng@outlook.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Thomas Graf <tgraf@suug.ch>,
 Zhengchao Shao <shaozhengchao@huawei.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Jinjie Ruan <ruanjinjie@huawei.com>, Nikolay Aleksandrov <nikolay@redhat.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] netlink: Fix off-by-one error in netlink_proto_init()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TT4XjSjVt+rEbf84WFV9lJ2jYZz/ENVfqTKLdxoeInfwoiB5GOj
 cHbwOHrInIJtM78rhKCuYzwiNNWamMzP4y223UhR78JIPxnt5pSVwgU29GTuY8C6PU44tfk
 dh7nOr8vGKhPtWeKpjnySQRCQq0MJv+0dqiOyoE2dZZRPD3u03+V3pMiYzpHyyIjKcSZz5F
 jutCb4cH/ICMbNYFG7I7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vnA235YDMu8=;pry/bWJb/v0/8QCGck6fv7V9qia
 OMcoze3zWxQxCdCC0UYGYiUJQ0fIPoN/mIGI6iMhBap86MIRpdxv91OfTHpFRnHaZZiXWmsLp
 INmQ0s3o1z3cCtybeP/WCn8A1QDjLFokKDcavKEBesFkdxFF/KcbmEjAKcs1FGIdOyMI+gIPR
 QRgyqrKwlzZY2x65cxqzuVynbTfLgc+Mz1o2KFg1UzhzKsabhzsPRn6kGU6A2dY6G7YJmrMuK
 Caq0bUP2Lt5oOkkcZZy6dMhytg8dAGoRzg61RROLozZ/HhvcgPL2lhSTR1dIQCowa3KIDIzTD
 xsdHsBoChP4ycDGMfzV/3BE+y8adSiaZFQ+9zeCX96fBCtcAATgsP97NR8zcepIVHw6fRe2Ds
 kqRUpNRDUUMeRAp+3svMnLxjoptkmQKp3JL60nh2XZqshaglnvzQkUbX3K8B/9xRH1P+f+GIF
 Fp7r6Qi8jR6MSIlDFkDY7CcJjY3RuCHcZiqkrY3TWkgCiuhN3gxVVx+6d61YqXo0b68i/x2Z0
 vq3Ln1Pj7aey/6BzyMc/frY769X4pWl8/16/se4AvRho8+/xa7j30EtLrYqIHYUy8zBO5Yuhm
 akSFTVRyIXOue1IEtkc4LKHrKSWN6YatS4PuT+djL9Q08IzBdB1XveLA/WkuGYL20pCX94tMv
 33xafYy+AxaSxU0r1KhWJ3zbJBQhjwqaXsrdXcd5vBpZ/mkVb6Si7EYzSRn4nbvraNnAL1rWj
 SpJlPHEG3NBfnSJYcBuX20oj/MZQ7Z2ckVk//nJrqldmoTtGy6xz3KIxx8OOtRGDcy6ghaB76
 oyFOS8KbCMdFpC/WfA2qy0FA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 3 Nov 2024 14:01:26 +0100

Hash tables should be properly destroyed after a rhashtable_init() call
failed in this function implementation.
The corresponding exception handling was incomplete because of
a questionable condition check.
Thus use the comparison operator =E2=80=9C>=3D=E2=80=9D instead for the af=
fected while loop.

This issue was transformed by using the Coccinelle software.

Fixes: e341694e3eb5 ("netlink: Convert netlink_lookup() to use RCU protect=
ed hash table")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/netlink/af_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 0a9287fadb47..9601b85dda95 100644
=2D-- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2936,7 +2936,7 @@ static int __init netlink_proto_init(void)
 	for (i =3D 0; i < MAX_LINKS; i++) {
 		if (rhashtable_init(&nl_table[i].hash,
 				    &netlink_rhashtable_params) < 0) {
-			while (--i > 0)
+			while (--i >=3D 0)
 				rhashtable_destroy(&nl_table[i].hash);
 			kfree(nl_table);
 			goto panic;
=2D-
2.47.0


