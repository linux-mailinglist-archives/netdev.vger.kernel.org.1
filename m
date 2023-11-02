Return-Path: <netdev+bounces-45792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E55E7DF9DC
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 19:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C1DB20BB1
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 18:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6A521344;
	Thu,  2 Nov 2023 18:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2D11DFE6
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 18:25:40 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB99F128
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 11:25:38 -0700 (PDT)
Received: from [192.168.1.129] ([37.4.248.43]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MC3H1-1rAP1B2nhF-00CRul for <netdev@vger.kernel.org>; Thu, 02 Nov 2023
 19:25:36 +0100
Message-ID: <25e38ad0-fecc-469a-acfb-2ff276e5d0e8@i2se.com>
Date: Thu, 2 Nov 2023 19:25:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: netdev@vger.kernel.org
From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Reach out to the QCA7000 users
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mbmkfP6sxw2ccUqzVTHcjCvYljCNslt+CM4iwSrmMqxTC1VZ0QN
 EpPaHwjwKueFRhyvrZUf5E+r/nBijAMdri2jpsbal8nLSKtvzTqlQ1+HdCfdtIDBcTw5GLA
 l50n6HvA1WG83/6dQI8bXC1yINWRb5zB62mOn1wsVjCJGN/JdBE0ggUC1A44byihs5l+1ur
 uJUnwAASro3bLfrOF7L6w==
UI-OutboundReport: notjunk:1;M01:P0:Vlw9TSQg5y4=;6AbzAzZ3GRkiuQlcJBygHYkPZyN
 9eCEXJVRK82jl0a4wAhx2rv2uamI74ALrd0CSiAoBuNUZP4ZyU7CmTWWb4VsoSIyBUnBSjmNu
 yov48cCvii4sColx836C0juapsTufq02bDYJGn7mj8YIaSsslbe4THzl0xjOpPsYcpFPoTlD1
 r5nIFCmFnDgNBjq5TJvoQ15UqZgf65oKvuJZfVpcvgM2l4UxFpvaSHzWaBIMvqAHAuJVDWfK/
 14binaSal5mc3V8a3qcizyvMEOuG4T6G0v1RPCj3vJfjbV3gYO5i/gsaZWRMTdMvh6NZJlBpu
 nCTx1H6SfNBE7HMvLvCal2r/zHqjVsdBIEPbBV5k2KHJfhiHQ0eCbK0vfBXMMwIRo6y6oteEO
 IUakifnnl7qcyfqUE4n4EPewkWec9i4O8ExDdaHs8YdqUrV79MmKdsoHWfZr22spLmOdWbgaL
 DpZDZQVggcL2IM+/riEKg/sZhtigW+eO1pmzFfYW4m3cN0ihYuMux0rIw9LskkKeYBrylPEQU
 iOSzqh0/lLkL9Fyqz74pZNJwOU9Xb1UBkGueDBqUwsxfbxqw9+are1zwzqKE+LjVhBEF9YLLZ
 QPD+d0u54/kpsYdkakNPG45pMtWvcZJYjEIwuubDSu2v0rsQfSm6UQbXaW/nuLaHpiU1Q144x
 DycRA2Wzmjx+/kAVvjvBEv2CQteGaxMoyDlbb51uMSIvUUU9gxfUMg7+svzMrIexfo6Yq/l77
 4O7bQuE95osIGHsF2sKxZcOkelYEsArPOWKvUWFnrESq13DT7FvjzCSZ5hMWpBWohzA3UFkMo
 G/wtY8UiqYtXiZnpI9I/oDlOulQWJWflzQ5NemLwNB4gJM/uJKN/0tO13d7Qbyxw+ZlPDl94U
 4qAAjwb+K/cXetw==

Hi,

it's now 9 years ago, that the SPI driver for the QCA7000 (qca_spi) has 
been mainlined from this Qualcomm repo [1]. Since then Electric Mobility 
become quite popular and a significant amount of CCS charging stations 
use this chip or a compatible variant.

So i assume there are a lot of users of the qca_spi driver.

Here are my questions to the community:
- Are you aware of any issues with this driver?
- Are there any feature requests?

Thanks in advance

[1] - https://github.com/qca/qca7000/

