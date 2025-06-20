Return-Path: <netdev+bounces-199672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45024AE162C
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 10:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD203B4506
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 08:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAEB2AD16;
	Fri, 20 Jun 2025 08:33:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101BA218E99
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750408422; cv=none; b=ZgLZ2ZG/BnFrDjvATx9CoFRsl54GA1MZ+uhPWmq2gRZlMqn7qd0YHamFl9zCFqHrmz/GzxG7VRIlroX5AwArD8D4f0uwcHZSGEzUT+PKJH97jwU8r8xbQythJ/hd1/b2qfuKTYl3DZCjpiF7IhJVhPYZB4dWCC8KvRO6uHByW6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750408422; c=relaxed/simple;
	bh=QiEnCqWXPNoL67aGtsbVyz+4darjkA0+jHLpdCLIQlA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=bBrlV/iMMPduouIRBnhRI1YJ6MD0jrSfqpV/H637NEHjysleUNiTk7OV7jYlgNJSMs/h90Nu0OrhmbpXgJovD7ijaZXvJyeWVz3p/NI9MtQnk6V31QfXXPAjQh2uLEDlx/8ufzyYXIVIqaMwN76/L98Dt6wzb6oNA9kADU2hw94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz9t1750408359ta5811b8f
X-QQ-Originating-IP: wmVcnM5Aid3C57HyT5xrc+eAQGgemueaBqG9SbqHg78=
Received: from smtpclient.apple ( [60.176.0.129])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 20 Jun 2025 16:32:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10876364880833468779
EX-QQ-RecipientCnt: 9
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH net-next 01/12] net: libwx: add mailbox api for wangxun vf
 drivers
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <aFKK+SiUG1jMXr10@mev-dev.igk.intel.com>
Date: Fri, 20 Jun 2025 16:32:25 +0800
Cc: netdev@vger.kernel.org,
 kuba@kernel.org,
 pabeni@redhat.com,
 horms@kernel.org,
 andrew+netdev@lunn.ch,
 duanqiangwen@net-swift.com,
 linglingzhang@trustnetic.com,
 jiawenwu@net-swift.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A2EADA94-CB0D-4C04-8D85-17C6FA7352F5@net-swift.com>
References: <20250611083559.14175-1-mengyuanlou@net-swift.com>
 <20250611083559.14175-2-mengyuanlou@net-swift.com>
 <aFKK+SiUG1jMXr10@mev-dev.igk.intel.com>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NbLMjDNEDlGt9Cog7qI3Yl+Vbn4jnZANZSKaRzPPd7kol0OVuXpGJe9V
	Bh6EA4W4YSD6eBiXFCo51CzjfgFJ+3NhfilDuLJGJaoCf3RxTOk1dvRALdKKeeIDChjxhRI
	rn40hwHtzy3SUtNqw/QoA36oUZX4k7KtBJ4O35g+Qqby8fts/8M4EA/tInATMiNCXFyVIpC
	LPff0rToSU/5NBPusX+Kkiy/GxQYw6y4LWat0YaY48XQd3GtrXilbPbLf5WBgBwHPlWJE0d
	t4jwkhoDoT50iw86UCAsWeyKGfwg3qGQ8FNDA/lg2lZWkpQrH8lwxOmPG6+v27QZC0lnFA0
	edZqgiSHpDDSwYzrY3FkN04VMOyaBhDpAEaKfIejDLCUfsqrZiejRie/Ch+Q3nFSnnrs1kQ
	wCk+c3kxDN9Y6l2trJxeC1tB14KGJrBV8DSxn+e+J3VG6GbJkj7sOYUepDXnY1Wr1LY1Uas
	peN8aVdZn7XfzbUdavppQCKvwy76Bu967iPF4cRn5T/yqb+AxfKv9dyI4ZKDgEZ6DJixrJ0
	jW40c6sTNWFfhOWtK66Xtzhjy0FJLaHmqnr8Pb0BLNrb3onel2vsbIuD8sXzCpt6fTIZepA
	YXIcSWQR6ruAXH3ih2bh+jE60/cVeoAYmg1INf0syIAm3aXBjIyk6RR8Z8X6AYWAc/3R2Gp
	Vn8lQOPBXeBwuwAQ2F92GobuY6Tx4/qNF4ZLboarmBDE2udgTyBCM9RJEgqstfm0c5U6FnB
	O7g2pltHYWiMdXf6HYHDKTY607ueN1Ax7CVtG8Y5LvQ0Vq/dDVMf2OsP38ftEkc1Jx08fFj
	nMuDfFOc3/3AlZzOZntQJywniOTIOCWyJOBec1qnorkXcCN+LKDpfz2BaosL7/+R7f7n1a8
	RVxun785lcFRJynzJSWptD9WN++wncdrvt3oG+vkAgUTMSQnK/StDwCQkjfhDjwqwQIVGDf
	eR4x0nHq5PeoPBDInsYJFyk+CiNecifetpGdXZheWxuJvJnl3pc+3DYiTRVYZRwRa1VwjdS
	JnTj6VxFyCmHwUs1gSRccYXVAgvtDTu/3X63kiTA==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=8818=E6=97=A5 17:46=EF=BC=8CMichal Swiatkowski =
<michal.swiatkowski@linux.intel.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Wed, Jun 11, 2025 at 04:35:48PM +0800, Mengyuan Lou wrote:
>> Implements the mailbox interfaces for Wangxun vf drivers which
>> will be used in txgbevf and ngbevf.
>>=20
>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>> ---
>> drivers/net/ethernet/wangxun/libwx/wx_mbx.c  | 256 =
+++++++++++++++++++
>> drivers/net/ethernet/wangxun/libwx/wx_mbx.h  |  22 ++
>> drivers/net/ethernet/wangxun/libwx/wx_type.h |   3 +
>> 3 files changed, 281 insertions(+)
>>=20
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c =
b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
>> index 73af5f11c3bd..ebfa07d50bd2 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.c
>> @@ -174,3 +174,259 @@ int wx_check_for_rst_pf(struct wx *wx, u16 vf)
>>=20
>> return 0;
>> }
>> +
>> +static u32 wx_read_v2p_mailbox(struct wx *wx)
>> +{
>> + u32 mailbox =3D rd32(wx, WX_VXMAILBOX);
>> +
>> + mailbox |=3D wx->mbx.mailbox;
>> + wx->mbx.mailbox |=3D mailbox & WX_VXMAILBOX_R2C_BITS;
>> +
>> + return mailbox;
>> +}
>> +
>> +/**
>> + *  wx_obtain_mbx_lock_vf - obtain mailbox lock
>> + *  @wx: pointer to the HW structure
>> + *
>> + *  Return: return 0 on success and -EBUSY on failure
>> + **/
>> +static int wx_obtain_mbx_lock_vf(struct wx *wx)
>> +{
>> + int count =3D 5;
>> + u32 mailbox;
>> +
>> + while (count--) {
>> + /* Take ownership of the buffer */
>> + wr32(wx, WX_VXMAILBOX, WX_VXMAILBOX_VFU);
>> +
>> + /* reserve mailbox for vf use */
>> + mailbox =3D wx_read_v2p_mailbox(wx);
>> + if (mailbox & WX_VXMAILBOX_VFU)
>> + return 0;
>> + }
>=20
> You can try to use read_poll_timeout(). In other poll also.
>=20
>> +
>> + wx_err(wx, "Failed to obtain mailbox lock for VF.\n");
>> +
>> + return -EBUSY;
>> +}
>> +
>> +static int wx_check_for_bit_vf(struct wx *wx, u32 mask)
>> +{
>> + u32 mailbox =3D wx_read_v2p_mailbox(wx);
>> +
>> + wx->mbx.mailbox &=3D ~mask;
>> +
>> + return (mailbox & mask ? 0 : -EBUSY);
>> +}
>> +
>> +/**
>> + *  wx_check_for_ack_vf - checks to see if the PF has ACK'd
>> + *  @wx: pointer to the HW structure
>> + *
>> + *  Return: return 0 if the PF has set the status bit or else -EBUSY
>> + **/
>> +static int wx_check_for_ack_vf(struct wx *wx)
>> +{
>> + /* read clear the pf ack bit */
>> + return wx_check_for_bit_vf(wx, WX_VXMAILBOX_PFACK);
>> +}
>> +
>> +/**
>> + *  wx_check_for_msg_vf - checks to see if the PF has sent mail
>> + *  @wx: pointer to the HW structure
>> + *
>> + *  Return: return 0 if the PF has got req bit or else -EBUSY
>> + **/
>> +int wx_check_for_msg_vf(struct wx *wx)
>> +{
>> + /* read clear the pf sts bit */
>> + return wx_check_for_bit_vf(wx, WX_VXMAILBOX_PFSTS);
>> +}
>> +
>> +/**
>> + *  wx_check_for_rst_vf - checks to see if the PF has reset
>> + *  @wx: pointer to the HW structure
>> + *
>> + *  Return: return 0 if the PF has set the reset done and -EBUSY on =
failure
>> + **/
>> +int wx_check_for_rst_vf(struct wx *wx)
>> +{
>> + /* read clear the pf reset done bit */
>> + return wx_check_for_bit_vf(wx,
>> +   WX_VXMAILBOX_RSTD |
>> +   WX_VXMAILBOX_RSTI);
>> +}
>> +
>> +/**
>> + *  wx_poll_for_msg - Wait for message notification
>> + *  @wx: pointer to the HW structure
>> + *
>> + *  Return: return 0 if the VF has successfully received a message =
notification
>> + **/
>> +static int wx_poll_for_msg(struct wx *wx)
>> +{
>> + struct wx_mbx_info *mbx =3D &wx->mbx;
>> + int countdown =3D mbx->timeout;
>> +
>> + while (countdown && wx_check_for_msg_vf(wx)) {
>> + countdown--;
>> + if (!countdown)
>> + break;
>> + udelay(mbx->udelay);
>> + }
>=20
> Here
>=20
>> +
>> + return countdown ? 0 : -EBUSY;
>> +}
>> +
>> +/**
>> + *  wx_poll_for_ack - Wait for message acknowledgment
>> + *  @wx: pointer to the HW structure
>> + *
>> + *  Return: return 0 if the VF has successfully received a message =
ack
>> + **/
>> +static int wx_poll_for_ack(struct wx *wx)
>> +{
>> + struct wx_mbx_info *mbx =3D &wx->mbx;
>> + int countdown =3D mbx->timeout;
>> +
>> + while (countdown && wx_check_for_ack_vf(wx)) {
>> + countdown--;
>> + if (!countdown)
>> + break;
>> + udelay(mbx->udelay);
>> + }
>=20
> And here
>=20
>> +
>> + return countdown ? 0 : -EBUSY;
>> +}
>> +
>> +/**
>> + *  wx_read_posted_mbx - Wait for message notification and receive =
message
>> + *  @wx: pointer to the HW structure
>> + *  @msg: The message buffer
>> + *  @size: Length of buffer
>> + *
>> + *  Return: returns 0 if it successfully received a message =
notification and
>> + *  copied it into the receive buffer.
>> + **/
>> +int wx_read_posted_mbx(struct wx *wx, u32 *msg, u16 size)
>> +{
>> + int ret;
>> +
>> + ret =3D wx_poll_for_msg(wx);
>> + /* if ack received read message, otherwise we timed out */
>> + if (!ret)
>> + ret =3D wx_read_mbx_vf(wx, msg, size);
>> +
>> + return ret;
>=20
> Nit, but usuall error path is in if statement. Sth like:
>=20
> if (ret)
> return ret;
>=20
> return wx_read_mbx_vf();
>=20
> can be more readable for someone.
>=20
>> +}
>> +
>> +/**
>> + *  wx_write_posted_mbx - Write a message to the mailbox, wait for =
ack
>> + *  @wx: pointer to the HW structure
>> + *  @msg: The message buffer
>> + *  @size: Length of buffer
>> + *
>> + *  Return: returns 0 if it successfully copied message into the =
buffer and
>> + *  received an ack to that message within delay * timeout period
>> + **/
>> +int wx_write_posted_mbx(struct wx *wx, u32 *msg, u16 size)
>> +{
>> + int ret;
>> +
>> + /* send msg */
>> + ret =3D wx_write_mbx_vf(wx, msg, size);
>> + /* if msg sent wait until we receive an ack */
>> + if (!ret)
>> + ret =3D wx_poll_for_ack(wx);
>> +
>> + return ret;
>> +}
>> +
>> +/**
>> + *  wx_write_mbx_vf - Write a message to the mailbox
>> + *  @wx: pointer to the HW structure
>> + *  @msg: The message buffer
>> + *  @size: Length of buffer
>> + *
>> + *  Return: returns 0 if it successfully copied message into the =
buffer
>> + **/
>> +int wx_write_mbx_vf(struct wx *wx, u32 *msg, u16 size)
>> +{
>> + struct wx_mbx_info *mbx =3D &wx->mbx;
>> + int ret, i;
>> +
>> + /* mbx->size is up to 15 */
>> + if (size > mbx->size) {
>> + wx_err(wx, "Invalid mailbox message size %d", size);
>> + return -EINVAL;
>> + }
>> +
>> + /* lock the mailbox to prevent pf/vf race condition */
>> + ret =3D wx_obtain_mbx_lock_vf(wx);
>> + if (ret)
>> + return ret;
>> +
>> + /* flush msg and acks as we are overwriting the message buffer */
>> + wx_check_for_msg_vf(wx);
>> + wx_check_for_ack_vf(wx);
>=20
> Isn't checking returned value needed here?

The status of the register is read clear=EF=BC=8C so do not care about =
it.

>=20
>> +
>> + /* copy the caller specified message to the mailbox memory buffer =
*/
>> + for (i =3D 0; i < size; i++)
>> + wr32a(wx, WX_VXMBMEM, i, msg[i]);
>> +
>> + /* Drop VFU and interrupt the PF to tell it a message has been sent =
*/
>> + wr32(wx, WX_VXMAILBOX, WX_VXMAILBOX_REQ);
>=20
> It isn't clear that it drops lock, maybe do it in a function like
> wx_drop_mbx_lock_vf()? (just preference)
>=20
>> +
>> + return 0;
>> +}
>> +
>> +/**
>> + *  wx_read_mbx_vf - Reads a message from the inbox intended for vf
>> + *  @wx: pointer to the HW structure
>> + *  @msg: The message buffer
>> + *  @size: Length of buffer
>> + *
>> + *  Return: returns 0 if it successfully copied message into the =
buffer
>> + **/
>> +int wx_read_mbx_vf(struct wx *wx, u32 *msg, u16 size)
>> +{
>> + struct wx_mbx_info *mbx =3D &wx->mbx;
>> + int ret;
>> + u16 i;
>=20
> int ret, i; like in previous function
>=20
>> +
>> + /* limit read to size of mailbox and mbx->size is up to 15 */
>> + if (size > mbx->size)
>> + size =3D mbx->size;
>> +
>> + /* lock the mailbox to prevent pf/vf race condition */
>> + ret =3D wx_obtain_mbx_lock_vf(wx);
>> + if (ret)
>> + return ret;
>> +
>> + /* copy the message from the mailbox memory buffer */
>> + for (i =3D 0; i < size; i++)
>> + msg[i] =3D rd32a(wx, WX_VXMBMEM, i);
>> +
>> + /* Acknowledge receipt and release mailbox, then we're done */
>> + wr32(wx, WX_VXMAILBOX, WX_VXMAILBOX_ACK);
>=20
> Oh, so any value written into WX_VXMAILVOX drop the lock. Ignore my
> comment about function for that.
>=20
>> +
>> + return 0;
>> +}
>> +
>> +int wx_init_mbx_params_vf(struct wx *wx)
>> +{
>> + wx->vfinfo =3D kcalloc(1, sizeof(struct vf_data_storage),
>> +     GFP_KERNEL);
>=20
> Why kcalloc() for 1 element?
This code was synchronized from pf. Since pf needs to allocate several =
of them.
And I forgot to change it.


>=20
>> + if (!wx->vfinfo)
>> + return -ENOMEM;
>> +
>> + /* Initialize mailbox parameters */
>> + wx->mbx.size =3D WX_VXMAILBOX_SIZE;
>> + wx->mbx.mailbox =3D WX_VXMAILBOX;
>> + wx->mbx.udelay =3D 10;
>> + wx->mbx.timeout =3D 1000;
>> +
>> + return 0;
>> +}
>> +EXPORT_SYMBOL(wx_init_mbx_params_vf);
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h =
b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
>> index 05aae138dbc3..82df9218490a 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_mbx.h
>> @@ -11,6 +11,20 @@
>> #define WX_PXMAILBOX_ACK     BIT(1) /* Ack message recv'd from VF */
>> #define WX_PXMAILBOX_PFU     BIT(3) /* PF owns the mailbox buffer */
>>=20
>> +/* VF Registers */
>> +#define WX_VXMAILBOX         0x600
>> +#define WX_VXMAILBOX_REQ     BIT(0) /* Request for PF Ready bit */
>> +#define WX_VXMAILBOX_ACK     BIT(1) /* Ack PF message received */
>> +#define WX_VXMAILBOX_VFU     BIT(2) /* VF owns the mailbox buffer */
>> +#define WX_VXMAILBOX_PFU     BIT(3) /* PF owns the mailbox buffer */
>> +#define WX_VXMAILBOX_PFSTS   BIT(4) /* PF wrote a message in the MB =
*/
>> +#define WX_VXMAILBOX_PFACK   BIT(5) /* PF ack the previous VF msg */
>> +#define WX_VXMAILBOX_RSTI    BIT(6) /* PF has reset indication */
>> +#define WX_VXMAILBOX_RSTD    BIT(7) /* PF has indicated reset done =
*/
>> +#define WX_VXMAILBOX_R2C_BITS (WX_VXMAILBOX_RSTD | \
>> +    WX_VXMAILBOX_PFSTS | WX_VXMAILBOX_PFACK)
>> +
>> +#define WX_VXMBMEM           0x00C00 /* 16*4B */
>> #define WX_PXMBMEM(i)        (0x5000 + (64 * (i))) /* i=3D[0,63] */
>>=20
>> #define WX_VFLRE(i)          (0x4A0 + (4 * (i))) /* i=3D[0,1] */
>> @@ -74,4 +88,12 @@ int wx_check_for_rst_pf(struct wx *wx, u16 =
mbx_id);
>> int wx_check_for_msg_pf(struct wx *wx, u16 mbx_id);
>> int wx_check_for_ack_pf(struct wx *wx, u16 mbx_id);
>>=20
>> +int wx_read_posted_mbx(struct wx *wx, u32 *msg, u16 size);
>> +int wx_write_posted_mbx(struct wx *wx, u32 *msg, u16 size);
>> +int wx_check_for_rst_vf(struct wx *wx);
>> +int wx_check_for_msg_vf(struct wx *wx);
>> +int wx_read_mbx_vf(struct wx *wx, u32 *msg, u16 size);
>> +int wx_write_mbx_vf(struct wx *wx, u32 *msg, u16 size);
>> +int wx_init_mbx_params_vf(struct wx *wx);
>> +
>> #endif /* _WX_MBX_H_ */
>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h =
b/drivers/net/ethernet/wangxun/libwx/wx_type.h
>> index 7730c9fc3e02..f2061c893358 100644
>> --- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
>> @@ -825,6 +825,9 @@ struct wx_bus_info {
>>=20
>> struct wx_mbx_info {
>> u16 size;
>> + u32 mailbox;
>> + u32 udelay;
>> + u32 timeout;
>> };
>>=20
>> struct wx_thermal_sensor_data {
>> --=20
>> 2.30.1
>=20


